class Tags::Builder
  PAGE_LIMIT = 20
  def self.index page
    collection = []
    index_collection(page).each do |row|
      collection.push(build_tag(row))
    end
    collection
  end

  def self.build_tag row
    {
      id: row.id,
      clean_tag: row.clean_tag,
      tag: row.tag.tag,
      tag_id: row.tag.id
    }
  end


  private
  def self.index_collection page
    CleanTag.include(:tag).by_limit(page, PAGE_LIMIT)
  end
end
