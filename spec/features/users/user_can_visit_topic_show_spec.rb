require 'rails_helper'

describe 'User' do
  describe 'can visit topic page' do
    it 'can see their topics' do
      user = create(:user)
      topic_1 = create(:topic, user_id: user.id)
      topic_2 = create(:topic, user_id: user.id, complete: true)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

     visit user_dashboard_path
      click_on topic_1.title

      expect(current_path).to eq(user_topic_path(topic_1))
      expect(page).to have_content(topic_1.title)
      expect(page).to have_content(topic_1.goal)
    end
  end
  it "can create a question" do
    user = create(:user)
    topic_1 = create(:topic, user_id: user.id)

    visit user_topic_path(topic_1)

    fill_in "Question", with: "Do I need a lawyer?"
    click_on "New Question"

    expect(page).to have_content("My Questions:")
    expect(page).to have_content("Do I need a lawyer?")
  end

  it "Searches bing using question titles" do
    user = create(:user)
    topic_1 = create(:topic, user_id: user.id, title: "Disabilty in Colorado")

    visit user_topic_path(topic_1)

    fill_in "Question", with: "Do I need a lawyer?"
    click_on "New Question"

    expect(page).to have_content("Bing results:")
    expect(page).to have_css(".search_results", count: 5)
  end
end
