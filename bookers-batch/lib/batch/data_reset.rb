class Batch::DataReset
  def self.data_reset
    #投稿をすべて削除
    Book.delete_all
    p "投稿をすべて削除しました"
  end
end