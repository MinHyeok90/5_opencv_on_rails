require 'opencv'
include OpenCV

class HomeController < ApplicationController
  def index
  end

  def photo
    data = '/usr/share/opencv/haarcascades/haarcascade_frontalface_alt.xml'
    detector = CvHaarClassifierCascade::load(data)
    image = CvMat.load(params[:send_photo].path)
    detector.detect_objects(image).each do |region|
      color = CvColor::Blue
      image.rectangle! region.top_left, region.bottom_right, :color => color
    end
    image.save_image("output.png")
    send_file("output.png", disposition: 'inline')
  end
end
