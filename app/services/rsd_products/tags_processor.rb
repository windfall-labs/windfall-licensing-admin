class RsdProducts::TagsProcessor

  attr_accessor :rsd_product, :tags, :rsd_array, :tags_logs

  def initialize rsd_product, params={}
    @rsd_product = rsd_product
    @tags = params[:tags] || []
    @tags_logs = params[:tags_logs] || []
    prepare_tags
  end

  def process
    get_rsd_array
    rsd_array.each_with_index do |row, index|
      process_tag(row, index)
      process_tag(row, index, false) if index < rsd_array.size - 1
    end
    @rsd_product.update_attributes(manually_inspected: true)
  end

  private


  def prepare_tags
    tags_logs.reject!{|x| x.blank?}
    tags.reject!{|x| x.blank?}
    raise InvalidTagsError if tags.size != tags_logs.size
  end

  def get_rsd_array
    if rsd_product.rsd.split(' ').size != tags_logs.size
      rsd_product.tags_logs.delete_all
      @rsd_array = tags_logs
    else
      @rsd_array = rsd_product.rsd.split(' ')
    end
  end
  def process_tag tag, index, indiv=true
    tag = indiv ? tag : "#{rsd_array[index]} #{rsd_array[index+1]}"
    unclean_tag = get_unclean_tag(tag)
    clean_tag = indiv ? tags[index] : "#{tags[index]} #{tags[index+1]}"
    clean_tag_object = unclean_tag.clean_tag.present? ? unclean_tag.clean_tag : create_clean_tag(tag, clean_tag)
    unclean_tag.update_attributes(clean_tag_id: clean_tag_object.id)
  end

  def create_clean_tag tag, clean_tag
    tag_obj = create_tag tag
    clean_tag_obj = CleanTag.find_or_initialize_by(tag_id: tag_obj.id, clean_tag: clean_tag)
    clean_tag_obj.tag_count = clean_tag_obj.tag_count.present? ? clean_tag_obj.tag_count + 1 : 1
    clean_tag_obj.save!
    clean_tag_obj
  end

  def create_tag tag
    tag_obj = Tag.find_or_initialize_by(tag: tag)
    tag_obj.save!
    tag_obj
  end

  def get_unclean_tag tag
    unclean_tag = rsd_product.tags_logs.find_or_initialize_by(tag: tag)
    unclean_tag.save!
    unclean_tag
  end


end
