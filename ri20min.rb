def call_superclass(obj)
    base = obj.class
    p obj.class
    while !base.superclass.nil? do
      p base.superclass
      base = base.superclass
    end
end

class Word < String
    def palindrome?
        downcase == reverse.downcase
    end
end

class String
    def shuffle
        split("").shuffle.join
    end

    def shuffle!
        replace(split("").shuffle.join)
    end
end

hoge = "hoge"
p hoge.object_id
hoge.shuffle!
p hoge.object_id
p hoge