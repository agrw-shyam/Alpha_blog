module ApplicationHelper

  def profile_for(user, options = { size: 80 })
    size = options[:size]
    
    # Check if the user uploaded an image. 
    # If yes, use its URL. If not, point to your new defaults asset folder path.
    img_source = user.image_upload.present? ? user.image_upload.url : "defaults/profile.jpg"
    
    image_tag(img_source, alt: user.username, class: "rounded-circle", width: size, height: size)
  end

end
