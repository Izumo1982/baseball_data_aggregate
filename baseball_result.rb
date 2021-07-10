
PlayerArray = 
[[1,'出雲　一郎'],
[2,'出雲　弐郎'],
[3,'出雲　三郎'],
[4,'出雲　四郎'],
[5,'出雲　五郎'],
[11,'島根　一郎'],
[12,'島根　弐郎'],
[13,'島根　三郎'],
[14,'島根　四郎'],
[15,'島根　五郎']]

ResultArray = 
[[1,'安打',1,1],
[2,'二塁打',1,1],
[3,'三塁打',1,1],
[4,'本塁打',1,1],
[5,'四球',0,0],
[6,'死球',0,0],
[7,'失策',1,0],
[8,'犠打失策',0,0],
[11,'ゴロ',1,0],
[12,'飛',1,0],
[13,'併殺',1,0],
[14,'三振',1,0],
[15,'直',1,0],
[16,'犠飛',0,0],
[17,'振逃',1,0],
[18,'打撃妨害',0,0],
[19,'野手選択',1,0],
[20,'守備妨害',1,0],
[21,'犠打失策',0,0]]

RecordArray = 
[[1,1,1,1,0,5],
[2,1,1,2,0,5],
[3,1,1,3,1,8],
[4,1,1,4,0,14],
[5,1,1,5,8,1],
[6,1,1,11,9,1],
[7,1,1,12,6,12],
[8,1,1,13,0,5],
[9,1,1,14,1,8],
[10,1,2,15,9,12]]

class SQL
  def initialize(table)
    @table = table
  end

  def conversion_string(v)
    v.map! {|str| str.class == String ? "'#{str}'" : str } 
    v.join', '
  end

  def create(v)
    "INSERT INTO #{@table} VALUES(#{conversion_string(v)});"
  end

  def read(conditions, value = "*")
		value = value.join(', ') if value != "*"
    "SELECT #{value} FROM #{@table} #{where(conditions)};"
  end

  def update(conditions, value)
    "UPDATE #{@table} SET #{set_values(value)} #{where(conditions)};"
  end

  def delete(conditions)
    "DELETE from #{@table} #{where(conditions)};"
  end

  def set_values(h)
    eq(h)
  end

  def eq(h)
    str = ""
    h.each  {|key, value|  str = "#{str}#{key} = '#{value}', "}
    return str[0..-3]
  end

  def into_and(h)
    str = ""
    h.each  {|key, value|  str = "#{str}#{key} = '#{value}' AND "}
    return str[0..-6]# 最後のANDを消す
  end


  def where(h)
    return nil if h == ""
    "where #{into_and(h)}"
  end


end


# 例
player = SQL.new("player")
record = SQL.new("record")
result = SQL.new("result")

PlayerArray.each do |ar|
  p player.create(ar)
end

RecordArray.each do |ar|
  p record.create(ar)
end

ResultArray.each do |ar|
  p result.create(ar)
end
