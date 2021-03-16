module PostsHelper
  def output_array(caption)
    hashtags = Post.hashtag_scan(caption)
    cap_arr = []
    unless hashtags.present?
      cap_arr.push(caption[0..-1])
    else
      dup_hash = {}
      hashtags.uniq.each do |word|
        dup_hash[word] = 0
      end
      hash_point = hashtags.map do |num|
        top_point = caption.index(num, dup_hash[num])
        bottom_point = caption.index(num, dup_hash[num]) + num.length - 1
        dup_hash[num] = bottom_point
        [top_point, bottom_point]
      end
      first_cap = caption[0...hash_point[0][0]]
      cap_arr.push(first_cap)
      hash_point.each_with_index do |arr, i|
        tag = caption[arr[0]..arr[1]]
        usually_cap = caption[(hash_point[i-1][1] + 1)...hash_point[(i)][0]]
        cap_arr.push(usually_cap, tag)
      end
      last_cap = caption[(hash_point.last[1] + 1)..-1]
      cap_arr.push(last_cap)
    end
    cap_arr.map do |word|
      if word.match(Post.regular_expressions)
        delete_pound_word = word.delete("[#＃]")
        link_to word, "/post/hashtag/" + delete_pound_word
      else
        word
      end
    end
  end
end
