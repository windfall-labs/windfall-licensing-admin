require 'rails_helper'

describe "POST /api/tags" do
  let!(:user) {current_user}

  def post_request(creds)
    post '/api/session', { credentials: creds }
  end

  it 'creates clean tag records' do
    post_request({ email: user.email, password: "password1" })
    access_token = JSON.parse(response.body)["access_token"]
    rsd_product = create(:rsd_product)

    tags_log_chco = create(:tags_log, rsd_product_id: rsd_product.id, tag: "Chco")
    tags_log_br = create(:tags_log, rsd_product_id: rsd_product.id, tag: "Br")
    tags_log_chco_br = create(:tags_log, rsd_product_id: rsd_product.id, tag: "Chco Br")

    expect{
      post '/api/tags', {tag: {rsd_product_id: rsd_product.id, tags: ["Choco", "Bar"]}}, {'AccessToken' => access_token, 'UserId' => 1}
    }.to change{CleanTag.count}.by 3
  end
end
