# frozen_string_literal: true

# read sql from seeds.sql
sql = File.read('db/seeds.sql')

# split sql statements by ';'
statements = sql.split(/;$/)
statements.pop

# start the transaction
ActiveRecord::Base.transaction do
  # for each statement...
  statements.each do |statement|
    # use a capture group to get the id from the statement
    id = statement.match(/VALUES \('(?<id>\d{1,})/).captures[0]

    # skip to next statement if id is empty
    next if id.empty?

    # assemble query to check if row with id exists
    query = "select 1 from links where id=#{id}"

    # execute query and get the results
    results = ActiveRecord::Base.connection.execute(query)

    # if no results returned, then execute the statement
    unless results.any?
      ActiveRecord::Base.connection.execute(statement) unless results.any?
    end
  end
end
