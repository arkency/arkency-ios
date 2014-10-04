class PostRepository
  def initialize(blog_adapter = BlogAdapter.new)
    @blog_adapter = blog_adapter
  end

  def fetch_all_posts(all_posts_fetched_callback)
    parse_process = ParsingPostsProcess.new(all_posts_fetched_callback)

    @blog_adapter.fetch_blog_posts_feed(-> (xml_parser) { parse_process.start(xml_parser) })
  end

  private
  attr_reader :blog_adapter

  class ParsingPostsProcess
    def initialize(completion_callback)
      @completion_callback = completion_callback
      @data = {}

      @stack = []
      @title_being_entered = false
      @published_at_being_entered = false

      @posts = []
    end

    def start(xml_parser)
      xml_parser.delegate = self
      xml_parser.parse
    end

    private
    def parserDidEndDocument(parser)
      completion_callback.call(@posts)
    end

    def parser(parser, didStartElement: elementName, namespaceURI: _, qualifiedName: _, attributes: attributes)
      if @stack.last == 'entry' && elementName == 'title'
        @title_being_entered = true
      end

      if @stack.last == 'entry' && elementName == 'published'
        @published_at_being_entered = true
      end

      if @stack.last == 'entry' && elementName == 'link'
        @current_post[:url] = attributes['href']
      end

      if elementName == 'entry'
        @current_post = {}
      end

      @stack << elementName
    end

    def parser(parser, didEndElement: elementName, namespaceURI: _, qualifiedName: _)
      @stack.pop
      @title_being_entered = false
      @published_at_being_entered = false

      if elementName == 'entry'
        @posts << Post.new(@current_post[:url], @current_post[:title], @current_post[:published_at])
      end
    end

    def parser(parser, foundCharacters: characters)
      @current_post[:author]       = characters if @author_being_entered
      @current_post[:title]        = characters if @title_being_entered
      @current_post[:published_at] = characters if @published_at_being_entered
    end

    attr_reader :completion_callback
  end
end