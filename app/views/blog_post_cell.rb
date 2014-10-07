class BlogPostCell < UITableViewCell
  def initWithStyle(style, reuseIdentifier: reuseIdentifier)
    super

    layout = BlogPostCellLayout.new(root: self).build
    @image = layout.get(:image)
    @title = layout.get(:title)

    self
  end

  def blog_post=(blog_post)
    @image.url = 'http://blog.arkency.com/assets/images/react-keys-getinitial-state/react_children_keys-fit.jpg'
    @title.text = blog_post.title
  end
end

class BlogPostCellLayout < MotionKit::Layout
  def layout
    add UIImageView, :image do
      autoresizing_mask :pin_to_top, :flexible_width

      frame [[0, 0], ['100%', 200]]

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