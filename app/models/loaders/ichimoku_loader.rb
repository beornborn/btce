class IchimokuLoader < DataLoader
  def self.load_ichimoku_for_sure
    Hour
    ichimoku = Indicator.find_by(name: 'ichimoku')
    end_time = SystemData.find_by(name: "#{ichimoku.options[:model].table_name}_sure").val || ichimoku.options[:model].order('time asc').last.time
    load_ichimoku ichimoku, ichimoku.options[:for_sure], end_time, SULO6
    ichimoku.update_attribute(:options, ichimoku.options.merge({for_sure: ichimoku.ichimokus.order('time asc').last.time}))
  end

  def self.load_ichimoku ichimoku, time, end_time, logger = BeoLogger
    short_i, medium_i, long_i, time_unit, model = ichimoku.options[:short], ichimoku.options[:medium], ichimoku.options[:long], ichimoku.options[:time_unit], ichimoku.options[:model]
    time, end_time = round_to_interval(time - medium_i, time_unit), round_to_interval(end_time, time_unit)
    ichimoku.ichimokus.where("time >= ? AND time <= ?", time, end_time).delete_all

    short_a, medium_a, long_a = short_i / time_unit, medium_i / time_unit, long_i  / time_unit
    time = model.where('time >= ?', time).order('time asc').first.time

    while model.where('time > ? AND time <= ?', time - long_i - medium_i, time).count < long_a + medium_a
      logger.info "skip #{time} ''''''''''''''''''''''''''''''''''''''''''''''''"
      time += time_unit
    end

    batch = []
    while time <= end_time
      data = model.select('time, high, low, close').where('time > ? AND time <= ?', time - long_i - medium_i, time + medium_i).order('time asc').to_a
      current_index = medium_a + long_a - 1
      s = data[(current_index - short_a + 1)..current_index]
      m = data[(current_index - medium_a + 1)..current_index]
      
      tenkan_sen = (s.map(&:high).max + s.map(&:low).min) / 2 #
      kijun_sen = (m.map(&:high).max + m.map(&:low).min) / 2 #
      chinkou_span = data.last.close #
  
      s_m_spaned = data[(current_index - short_a + 1 - medium_a)..current_index - medium_a]
      m_m_spaned = data[(current_index - medium_a + 1 - medium_a)..current_index - medium_a]
      tenkan_sen_spaned = (s_m_spaned.map(&:high).max + s_m_spaned.map(&:low).min) / 2
      kijun_sen_spaned = (m_m_spaned.map(&:high).max + m_m_spaned.map(&:low).min) / 2
      senkou_span_a = (tenkan_sen_spaned + kijun_sen_spaned) / 2 #

      l_m_spaned = data[(current_index - long_a + 1 - medium_a)..current_index - medium_a]
      senkou_span_b = (l_m_spaned.map(&:high).max + l_m_spaned.map(&:low).min) / 2 #

      batch << Ichimoku.new(time: time, tenkan_sen: tenkan_sen, kijun_sen: kijun_sen, chinkou_span: chinkou_span, senkou_span_a: senkou_span_a, senkou_span_b: senkou_span_b, indicator: ichimoku) 
      time += time_unit
      
      if batch.size > 1000 || time > end_time
        logger.info "------------------------------- new #{model.to_s} ichimoku batch #{Time.now} ----------------------------------"
        logger.info "batch size: #{batch.size}"
        logger.info "first instance--- time: #{batch.first.time} tenkan_sen: #{batch.first.tenkan_sen}"
        logger.info "last instance---- time: #{batch.last.time} tenkan_sen: #{batch.last.tenkan_sen}"
        save_batch batch
        batch = []
      end
    end
  end
end
# tenkan_sen numeric(24,12),
#   kijun_sen numeric(24,12),
#   chinkou_span numeric(24,12),
#   senkou_span_a numeric(24,12),
#   senkou_span_b numeric(24,12),
# Тенкан-Сен Tenkan-sen=(Max(High,N)+Min(Low,N))/2, где Max (High,N) - Наивысший из максимумов за период, равный N - интервалов (например, N дней) 
# Min(Low,N), - Наименьший минимум за период, равный N - интервалов 
# N - длина периода 

# Кинджун-Сен 
# Kijun-sen =(Max(High,M)+Min(Low,M))/2 M - длина периода 

# Чинкоу Спен 
# Chinkou Span = Текущее Close, сдвинутое назад на M 

# Штрихованная область (облако) между 

# Сенкой Спен "А" 
# Senkou Span A = (Tenkan-sen+ Kijun-sen), сдвинутое вперед на M интервалов 

# Сенкой Спен "B"
# Senkou Span B = (Max(High,Z)+Min(Low,Z))/2, сдвинутое вперед на M интервалов 
# Z - длина интервала 
# Количество параметров - N, M, Z указанное самим автором для использования Ишимоку соответственно равно 9,26 и 52. Эти цифры беруться из следующих соотношений: 
# На дневном графике: 
# 9 - полторы рабочих недели, 26 - число рабочих дней в месяце (в Японии было 6 рабочих дней в неделю), а 52 - количество недель в году. На недельном графике: 
# 9 недель составляют примерно 2 месяца, 26 недель составляют полугодие, 52 недели - год.