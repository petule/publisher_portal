require "application_system_test_case"

class EbooksTest < ApplicationSystemTestCase
  setup do
    @ebook = ebooks(:one)
  end

  test "visiting the index" do
    visit ebooks_url
    assert_selector "h1", text: "Ebooks"
  end

  test "should create ebook" do
    visit ebooks_url
    click_on "New ebook"

    click_on "Create Ebook"

    assert_text "Ebook was successfully created"
    click_on "Back"
  end

  test "should update Ebook" do
    visit ebook_url(@ebook)
    click_on "Edit this ebook", match: :first

    click_on "Update Ebook"

    assert_text "Ebook was successfully updated"
    click_on "Back"
  end

  test "should destroy Ebook" do
    visit ebook_url(@ebook)
    click_on "Destroy this ebook", match: :first

    assert_text "Ebook was successfully destroyed"
  end
end
