class Api::V1::TagsController < ApiController
  def index
  end

  def create
  end

  def update
  end

  def delete
  end

  private
  def tags_params
    params.require(:tag).permit(
      :tag_id,
      :clean_tag
    )
  end

  def page_params
    params.permit(:page)
  end
end
