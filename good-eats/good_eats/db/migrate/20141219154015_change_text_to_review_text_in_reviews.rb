class ChangeTextToReviewTextInReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :text, :review_text
  end
end
