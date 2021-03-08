class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
    self.class.all << self
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name INTEGER, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?,?)", @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  
end
