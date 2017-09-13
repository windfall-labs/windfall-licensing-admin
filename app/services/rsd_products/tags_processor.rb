class RsdProducts::TagsProcessor

  attr_accessor :rsd_product, :tags, :rsd_array

  def initialize rsd_product, tags=[]
    @rsd_product = rsd_product
    @tags = tags
  end

  def process
    @rsd_array = rsd_product.rsd.split(' ')
    rsd_array.each_with_index do |row, index|
      process_tag(row, index)
      process_tag(row, index, false) if index < rsd_array.size - 1
    end
    @rsd_product.update_attributes(manually_inspected: true)
  end

  private
  def process_tag tag, index, indiv=true
    tag = indiv ? tag : "#{rsd_array[index]} #{rsd_array[index+1]}"
    unclean_tag = get_unclean_tag(tag)
    clean_tag = indiv ? tags[index] : "#{tags[index]} #{tags[index+1]}"
    clean_tag_object = unclean_tag.clean_tag.present? ? unclean_tag.clean_tag : create_clean_tag(tag, clean_tag)
    unclean_tag.update_attributes(clean_tag_id: clean_tag_object.id)
  end

  def create_clean_tag tag, clean_tag
    tag_obj = Tag.find_or_initialize_by(tag: tag)
    tag_obj.save!
    clean_tag_obj = CleanTag.find_or_initialize_by(tag_id: tag_obj.id, clean_tag: clean_tag)
    clean_tag_obj.save!
    clean_tag_obj
  end

  def get_unclean_tag tag
    unclean_tag = rsd_product.tags_logs.find_or_initialize_by(tag: tag)
    unclean_tag.save!
    unclean_tag
  end

end
