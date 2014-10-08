class BlogPostCell < UITableViewCell
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super

    layout = BlogPostCellLayout.new(root: self).build
    @image = layout.get(:image)
    @title = layout.get(:title)
    @published_at  = layout.get(:published_at)
    self
  end

  def blog_post=(blog_post)
    @image.url = blog_post.image_url
    @title.text = blog_post.title
    @published_at.text = present_date(blog_post.published_at)
  end

  private
  def present_date(date)
    formatter = NSDateFormatter.new
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    date = formatter.dateFromString(date)
    date.distanceOfTimeInWords
  end
end

class BlogPostCellLayout < MotionKit::Layout
  def layout
    add UIImageView, :image do
      autoresizing_mask :pin_to_top, :flexible_width

      frame [[0, 0], ['100%', 200]]
      content_mode UIViewContentModeScaleAspectFill
      clips_to_bounds true

      add UILabel, :published_at do
        font UIFont.fontWithName('AppleSDGothicNeo-Regular', size: 12)

        autoresizing_mask :pin_to_top_left, :flexible_width
        top -80
        size ['100% - 10', '100% - 10']

        text_color UIColor.whiteColor
        text_alignment NSTextAlignmentRight
        alpha 0.8
        shadow_color UIColor.blackColor
        shadow_offset [1.0, 1.0]
      end

      add UILabel, :title do
        autoresizing_mask :pin_to_bottom, :flexible_width

        left 10
        top 60
        size ['100% - 10', '100% - 10']
        number_of_lines 0
        shadow_color UIColor.blackColor
        shadow_offset [1.0, 1.0]

        line_break_mode UILineBreakModeWordWrap
        font UIFont.fontWithName('Futura-Medium', size: 18)

        text_color UIColor.whiteColor
        text_alignment NSTextAlignmentLeft
      end
    end
  end
end