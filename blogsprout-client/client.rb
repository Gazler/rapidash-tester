require 'rapidash'
require 'rspec'

class Reset < Rapidash::Base
  url :reset
end

module SomeModule
  class Messages < Rapidash::Base
    url :comments
    root :comment 
  end
end

class Posts < Rapidash::Base
  resource :messages, :class_name => SomeModule::Messages
  root :post 
end



class Client < Rapidash::Client
  method :http
  resource :posts, :reset
  use_patch
  site "http://localhost:3000/"
  extension :json

end

client = Client.new

describe "Rapidash integration tests" do

  it "resets the client" do
    client.reset!.should eql(nil)
  end

  describe "posts" do

    let(:post1) {
      {
        "author" => "Pro tests",
        "title" => "Test Post 1",
        "body" => "My first post",
        "published" => true
      }
    }

    let(:post2) {
      {
        "author" => "Pro tests",
        "title" => "Test Post 2",
        "body" => "My second post",
        "published" => true
      }
    }


    let(:post3) {
      {
        "author" => "Pro tests",
        "title" => "Prototype Post",
        "body" => "My unpublished post",
        "published" => false
      }
    }

    let(:result1)  {
      {"id" => 1, "url" => "http://localhost:3000/posts/1.json"}.merge(post1)
    }
    let(:result2) {
      {"id" => 2, "url" => "http://localhost:3000/posts/2.json"}.merge(post2)
    }
    let(:result3) {
      {"id" => 3, "url" => "http://localhost:3000/posts/3.json"}.merge(post3)
    }


    it "creates post 1" do
      client.posts.create!(post1).should eql({"id" => 1}.merge!(post1))
    end

    it "creates post 2" do
      client.posts.create!(post2).should eql({"id" => 2}.merge!(post2))
    end

    it "creates post 3" do
      client.posts.create!(post3).should eql({"id" => 3}.merge!(post3))
    end

    it "gets all the posts" do
      client.posts!.should eql([result1, result2, result3])
    end

    it "gets a single post" do
      client.posts!(1).should eql(post1.merge({"id"=> 1}))
    end

    it "updates the published status of post 3" do
      client.posts(3).update!(:published => true)
      client.posts!(3).should eql(post3.merge({"id"=> 3, "published" => true}))
    end

    it "deletes the second post" do
      client.posts(2).delete!
      client.posts!.should eql([result1, result3.merge("published" => true)])
    end

  end

  describe "messages" do
    
    let(:comment1) {
      {
        "author" => "Pro tests",
        "comment" => "Some comment"
      }
    }

    let(:comment2) {
      {
        "author" => "Pro tests",
        "comment" => "another comment"
      }
    }

    let(:comment3) {
      {
        "author" => "Pro tests",
        "comment" => "yet another comment"
      }
    }

    let(:result1)  {
      {"id" => 1, "post_id" => 1, "url" => "http://localhost:3000/posts/1/comments/1.json"}.merge(comment1)
    }

    let(:result2) {
      {"id" => 2, "post_id" => 1, "url" => "http://localhost:3000/posts/1/comments/2.json"}.merge(comment2)
    }

    let(:result3) {
      {"id" => 3, "post_id" => 1, "url" => "http://localhost:3000/posts/1/comments/3.json"}.merge(comment3)
    }



    it "creates comment 1" do
      client.posts(1).messages.create!(comment1).should eql({"id" => 1, "post_id" => 1}.merge!(comment1))
    end

    it "creates comment 2" do
      client.posts(1).messages.create!(comment2).should eql({"id" => 2, "post_id" => 1}.merge!(comment2))
    end

    it "creates comment 3" do
      client.posts(1).messages.create!(comment3).should eql({"id" => 3, "post_id" => 1}.merge!(comment3))
    end

    it "gets all the messages" do
      client.posts(1).messages!.should eql([result1, result2, result3])
    end

    it "gets a single post" do
      client.posts(1).messages!(1).should eql(comment1.merge({"id"=> 1, "post_id" => 1}))
    end

    it "updates the comment field of comment 3" do
      client.posts(1).messages(3).update!(:comment => "This has been updated")
      client.posts(1).messages!(3).should eql(comment3.merge({"id"=> 3, "comment" => "This has been updated", "post_id" => 1}))
    end

    it "deletes the second post" do
      client.posts(1).messages(2).delete!
      client.posts(1).messages!.should eql([result1, result3.merge("comment" => "This has been updated")])
    end

  end

end

