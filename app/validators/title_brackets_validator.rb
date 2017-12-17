class TitleBracketsValidator < ActiveModel::Validator
  BRACKETS_HASH = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }.freeze

  def validate(record)
    title_sans_spaces = record.title.delete(' ')

    unless valid_brackets(title_sans_spaces)
      record.errors.add :title, "Fix not matching brackets!"
    end
    unless empty_brackets(title_sans_spaces)
      record.errors.add :title, "You can't have empty brackets!"
    end
  end

  private

  def valid_brackets(title)
    stack = []
    title.each_char do |char|
      if BRACKETS_HASH.keys.include? char
        stack << char
      elsif BRACKETS_HASH.values.include? char
        return false if stack.empty? || (BRACKETS_HASH[stack.pop] != char)
      end
    end
    return stack.empty?
  end

  def empty_brackets(title)
    title.chars.each_cons(2) do |c1, c2|
      return false if c2 == BRACKETS_HASH[c1]
    end
    return true
  end
end