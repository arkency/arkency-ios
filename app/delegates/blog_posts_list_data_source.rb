class BlogPostsListInMemoryDataSource
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    case indexPath.row
      when 0 then firstSampleRow
      when 1 then secondSampleRow
      when 2 then thirdSampleRow
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    3
  end

  private
  def firstSampleRow
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: "test")
    cell.textLabel.text = "React.js and Dynamic Children - Why the Keys are Important"
    cell
  end

  def secondSampleRow
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: "test")
    cell.textLabel.text = "Behind the scenes"
    cell
  end

  def thirdSampleRow
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: "test")
    cell.textLabel.text = "How to start using UUID in ActiveRecord with PostgreSQL"
    cell
  end
end