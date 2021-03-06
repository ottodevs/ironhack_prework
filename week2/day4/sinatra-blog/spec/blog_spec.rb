require './models/blog'
require './models/post'

describe Blog do

  before :each do
    @blog = Blog.new
    @post = Post.new('title', 'text', 'author')
    @post2 = Post.new('title2', 'text2', 'author')
    @post3 = Post.new('title3', 'text3', 'author', 'category')
  end

  describe '#posts' do
    it 'should be empty at the beginning' do
      expect(@blog.posts).to be_empty
    end

    it 'contains @post in the collection' do
      @blog.add_post(@post)
      expect(@blog.posts).to include(@post)
    end
  end

  describe '#add_post' do
    it 'raises a TypeError when post is not Post class' do
      expect {@blog.add_post('fake_post')}.to raise_error(TypeError)
    end

    it 'adds exactly that @post' do
      expect(@blog.add_post(@post)).to contain_exactly(@post)
    end
  end

  describe '#find_post_by_title' do
    it 'returns nil if the post is not found' do
      title = @post.title
      expect(@blog.find_post_by_title(title)).to be_nil
    end

    it 'returns the post with that title' do
      @blog.add_post(@post)
      title = @post.title
      expect(@blog.find_post_by_title(title)).to eq(@post)
    end
  end

  describe '#latest_posts' do
    it 'should return an array with all posts' do
      [@post, @post2, @post3].each { |p| @blog.add_post p }
      expect(@blog.latest_posts).to match_array [@post, @post2, @post3]
    end

    it 'shows latest posts first' do
      [@post, @post3, @post2].each { |p| @blog.add_post p }
      expect(@blog.latest_posts).to eql [@post3, @post2, @post]
    end
  end

  describe '#find_by_category' do
    it 'should return an array' do
      expect(@blog.find_by_category('Uncategorized')).to be_a(Array)
    end

    it 'should return the posts inside that category' do
      [@post, @post3, @post2].each { |p| @blog.add_post p }
      expect(@blog.find_by_category('category')).to eql [@post3]
      expect(@blog.find_by_category('category')).to contain_exactly(@post3)
    end
  end

  describe '#categories' do
    it 'should return an array with each category' do
      [@post, @post3, @post2].each { |p| @blog.add_post p }
      expect(@blog.categories).to contain_exactly('Uncategorized', 'category')
    end
    
  end
end
