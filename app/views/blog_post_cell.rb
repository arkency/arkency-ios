class BlogPostCell < UITableViewCell
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super

    @titleLabel = UILabel.alloc.initWithFrame(CGRectMake(20, 20, 620, 100))
    @titleLabel.textColor = UIColor.whiteColor
    @titleLabel.font = UIFont.fontWithName("DamascusBold", size: 18)

    @imageView = UIImageView.new
    @imageView.url = "http://blog.arkency.com/assets/images/react-keys-getinitial-state/react_children_keys-fit.jpg"
    @imageView.addSubview(@titleLabel)

    composeCell

    self
  end

  def blog_post=(blog_post)
    @titleLabel.text = blog_post.title
    @titleLabel.lineBreakMode = UILineBreakModeCharacterWrap
    @titleLabel.numberOfLines = 0

    size = CGSizeMake(620, 10000)
  end

  private
  def composeCell
    Motion::Layout.new do |layout|
      layout.view self.contentView
      layout.subviews "imageView" => @imageView
      layout.vertical "|[imageView]|"
      layout.horizontal "|[imageView]|"
      layout.metrics "height" => 120
    end
  end

  attr_accessor :imageView
end