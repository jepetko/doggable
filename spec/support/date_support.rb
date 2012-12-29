module DateComponentsHelper

  def explode_date_comp(map)
    comp_map = {}
    map.each do |k,v|
      next if !v.is_a?(Date)
      c = [v.year, v.month, v.day]
      indices = 1..3
      indices.each do |index|
        comp_map[ "#{k}(#{index}i)".to_sym ] = c[index-1]
      end
      map.delete(k)
    end
    map.update(comp_map)
  end
end

RSpec.configure do |config|
  config.include DateComponentsHelper, :type => :controller
end