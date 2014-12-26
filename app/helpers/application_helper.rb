module ApplicationHelper
  def bootstrap_flash_notice
    unless flash[:notice].nil?
      render :partial=>'helper_fragments/flash_notice', :locals=>{notice:flash[:notice]}
    end
  end

  def bootstrap_flash_errors
    errors = flash[:errors]
    unless errors.nil? or errors.empty?
      render :partial=>'helper_fragments/flash_errors', :locals=>{errors:errors}
    end
  end
end