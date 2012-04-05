::Refinery::Admin::ImagesController.class_eval do

def ajax_create
    params[:image] = {:image => params[:image]}
    params[:image].each do  |image|
      @image = current_refinery_user.images.create(params[:image])
    end
    unless @image.errors.any?
      render :json => { :redirect_to => refinery.admin_images_path }
    else
      render :json => @image.errors, :status => 406
    end
  end

  def find_all_images(conditions = '')
    @images = ::Refinery::Image.where(conditions).order("created_at DESC") if current_refinery_user.has_role?(:superuser)
    @images = current_refinery_user.images.order("created_at DESC") if !current_refinery_user.has_role?(:superuser)
  end

end