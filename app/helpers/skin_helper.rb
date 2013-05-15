module SkinHelper

  STYLES = ['default', 'handbrokes', 'pancake', 'honies']

  def get_current_css
    if( !params.nil? ) then
      idx_int = params[:idx].to_i
      return 'skins/landbrokes'
    end
  end

  def define_stylesheet(idx)
    return STYLES[0] if idx.nil?
    return STYLES[idx]
  end

end
