require 'rails_helper'

describe "GET /api/tags" do
  let!(:user) {current_user}

  def post_request(creds)
    post '/api/session', { credentials: creds }
  end

  it 'returns rsd_products with tags' do
    post_request({ email: user.email, password: "password1" })
    access_token = JSON.parse(response.body)["access_token"]
    rsd_product = create(:rsd_product)

    tag_chco = create(:tag)
    tag_br = create(:tag, tag: "Br")
    tag_chco_br = create(:tag, tag: "Chco Br")

    clean_tag_chocolate = create(:clean_tag, tag_id: tag_chco.id)
    clean_tag_bar = create(:clean_tag, clean_tag: "Bar", tag_id: tag_br.id)

    tags_log_chco = create(:tags_log, rsd_product_id: rsd_product.id, tag: "Chco", clean_tag_id: clean_tag_chocolate.id)
    tags_log_br = create(:tags_log, rsd_product_id: rsd_product.id, tag: "Br", clean_tag_id: clean_tag_bar.id)
    tags_log_chco_br = create(:tags_log, rsd_product_id: rsd_product.id, tag: "Chco Br")

    get '/api/tags', nil, {'AccessToken' => access_token, 'UserId' => 1}
    body = JSON.parse(response.body)
    expect(body["collection"].any?).to eq(true)
    expect(body["collection"].first["tags"]).to eq(["Chocolate", "Bar"])
  end
end
