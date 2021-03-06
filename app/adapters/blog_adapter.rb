class BlogAdapter
  def initialize(base_url = 'http://blog.arkency.com/')
    @base_url = base_url
  end

  def fetch_blog_posts_feed(success_callback, failure_callback = nil)
    http_client.get('atom.xml') do |result|
      success_callback.call(result.object) if result.success?

      if result.failure?
        NSLog("error[%@] => %@", result.error.userInfo[NSURLErrorFailingURLErrorKey], result.error.localizedDescription)
        failure_callback.call(result.error) if failure_callback
      end
    end
  end

  private
  attr_reader :base_url
  def http_client
    @http_client ||= AFMotion::Client.build(base_url) do
      header "Content-Type", "application/rss+xml"
      serializer = AFXMLParserResponseSerializer.new
      serializer.acceptableContentTypes = NSSet.setWithObjects 'text/xml', 'application/atom+xml', 'application/rss+xml', nil
      response_serializer(serializer)
    end
  end
end