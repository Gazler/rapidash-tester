json.array!(@comments) do |comment|
  json.extract! comment, :id, :post_id, :author, :comment
  json.url post_comment_url(@post, comment, format: :json)
end
