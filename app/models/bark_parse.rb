class BarkParse < ActiveRecord::Base
  attr_accessible :bark_id, :x_choice, :x_clause, :x_hyper0, :x_hyper1, :x_hyper2plus, :x_loc_hyper0, :x_loc_hyper1, :x_loc_hyper2plus, :x_pp, :y_category, :y_clause, :y_hyper0, :y_hyper1, :y_hyper2plus, :y_loc_hyper0, :y_loc_hyper1, :y_loc_hyper2plus, :y_pp, :z_reason
  
  before_save :parse

  
  def parse
    y = Hash.new
    y[:location] = Array.new
    y[:pp] = Array.new
    y[:sub_clause] = Array.new
    leaf_counter = 0
    prep_position = nil
    arrayList = Rjb::import('java.util.ArrayList')
    pp_list = arrayList.new
    
	  pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit, :pos, :lemma, :parse, :ner, :dcoref)
	  category = StanfordCoreNLP::Text.new(self.y_category)
	  pipeline.annotate(category)

	  category.get(:sentences).each do |sentence|
		  root = sentence.get(:tree)
		
		  # Get each token(word) of each sentence
		  sentence.get(:tokens).each do |token|
			  #puts token.get(:value).to_s

			  # Store location
			  if token.get(:named_entity_tag).to_s == "LOCATION" then 
				  puts token.get(:value).to_s
				  y[:location] << token.get(:value).to_s
			  end	  
		  end
		  
		  if root.firstChild.nodeString == "S" then

    	  root.each do |t|
    		  if !t.equals(root) then
    			  if t.isLeaf then
    				  leaf_counter += 1
    			  end

    			  if t.nodeString == "IN" then
    				  if !pp_list.isEmpty then
    					  y[:pp] << pp_list
    					  pp_list = arrayList.new
    				  end

    				  pp_list.addAll(t.getLeaves)

    				  prep_position = root.leftCharEdge(t)
    			  end

    			  if prep_position != nil && root.leftCharEdge(t) > prep_position && t.isLeaf then
    				  pp_list.add(t)
    			  end

    			  if leaf_counter == root.getLeaves.size && !y[:pp].include?(pp_list) && !pp_list.isEmpty then
    				  y[:pp] << pp_list
    			  end

    			  if t.nodeString == "S" && t.parent(root).nodeString != "SBAR"  && t.parent(root).nodeString != "PP" then
    				  y[:sub_clause] << t.getLeaves
    			  end

    			  if t.nodeString == "NP" && y[:hyper0] == nil && t.lastChild.nodeString == "NNS" then
    			    y[:hyper0] = t.getLeaves
    				  y[:sub_clause].shift
    				  y[:hyper1] = t.lastChild.getLeaves
    			  end

    			  if t.nodeString == "SBAR" then
    				  y[:sub_clause] << t.getLeaves
    			  end
    		  end
    	  end

    	# If the y_text starts with y_hyper0. For example, "......pizza restaurants in
    	# Maryland"
      elsif root.firstChild.nodeString == "NP" then

    	  root.each do |t|
    		  if !t.equals(root) then
    			  if t.isLeaf then
    				  leaf_counter += 1
    			  end

    			  if t.nodeString == "IN" then
    				  if !pp_list.isEmpty then
    					  y[:pp] << pp_list
    					  pp_list = arrayList.new
    				  end

    				  pp_list.addAll(t.getLeaves)

    				  prep_position = root.leftCharEdge(t)
    			  end

    			  if prep_position != nil && root.leftCharEdge(t) > prep_position && t.isLeaf then
    				  pp_list.add(t)
    			  end

    			  if leaf_counter == root.getLeaves.size && !y[:pp].include?(pp_list) && !pp_list.isEmpty then
    				  y[:pp] << pp_list
    			  end

    			  if t.nodeString == "SBAR" then
    				  y[:sub_clause] << t.getLeaves
    			  end

    			  if y[:pp] == nil && t.nodeString == "NP" && !t.equals(root.firstChild) then
    				  y[:hyper0] = t.getLeaves
    			    y[:hyper1] = t.lastChild.getLeaves
    			  elsif y[:pp] != nil && y[:hyper0] == nil && t.nodeString == "NP" && !t.equals(root.firstChild) then
    				  y[:hyper0] = t.getLeaves
    				  y[:hyper1] = t.lastChild.getLeaves
    			  end
    		  end
    	  end

    	# if the y_text starts with a prepositional phrase and no y_hyper0. For example,
    	# "......for eating at in Maryland"
      elsif root.firstChild.nodeString == "PP" then

    	  root.each do |t|
    		  if !t.equals(root) then
    			  if t.isLeaf then
    				  leaf_counter += 1
    			  end

    			  if t.nodeString == "IN" then
    				  if !pp_list.isEmpty then
    					  y[:pp] << pp_list
    					  pp_list = arrayList.new
    				  end

    				  pp_list.addAll(t.getLeaves)

    				  prep_position = root.leftCharEdge(t)
    			  end

    			  if prep_position != nil && root.leftCharEdge(t) > prep_position && t.isLeaf then
    				  pp_list.add(t)
    			  end

    			  if leaf_counter == root.getLeaves.size && !y[:pp].include?(pp_list) && !pp_list.isEmpty then
    				  y[:pp] << pp_list
    			  end

    			  if t.nodeString == "SBAR" then
    				  y[:sub_clause] << t.getLeaves
    			  end
    		  end
    	  end

    	# if the y_text starts with a prepositional phrase that just consists of a 
    	# preposition and a noun (Location). For example, ".......in Maryland"
      elsif root.firstChild.nodeString == "FRAG" then

    	  root.each do |t|
    		  if !t.equals(root) then
    			  if t.isLeaf then
    				  leaf_counter += 1
    			  end

    			  if t.nodeString == "IN" && t.firstChild.nodeString != "if" then
    				  if !pp_list.isEmpty then
    					  y[:pp] << pp_list
    					  pp_list = arrayList.new
    				  end

    				  pp_list.addAll(t.getLeaves)

    				  prep_position = root.leftCharEdge(t)
    			  end

    			  if prep_position != nil && root.leftCharEdge(t) > prep_position && t.isLeaf then
    				  pp_list.add(t)
    			  end

    			  if leaf_counter == root.getLeaves.size && !y[:pp].include?(pp_list) && !pp_list.isEmpty then
    				  y[:pp] << pp_list
    			  end

    			  if t.nodeString == "S" && t.parent(root).nodeString != "SBAR"  && t.parent(root).nodeString != "PP" then
    				  y_category[:sub_clause] << t.getLeaves
    			  end

    			  if t.nodeString == "SBAR" then
    				  y_category[:sub_clause] << t.getLeaves
    			  end

    			  if y[:pp] == nil && t.nodeString == "NP" && t.lastChild.nodeString == "NNS" then
    				  y[:hyper0] = t.getLeaves
    				  y[:hyper1] = t.lastChild.getLeaves
    			  elsif y[:pp] != nil && y[:hyper0] == nil && t.nodeString == "NP" && t.lastChild.nodeString == "NNS" then
    				  y[:hyper0] = t.getLeaves
    				  y[:hyper1] = t.lastChild.getLeaves
    			  end
    		  end
    	  end

      elsif root.firstChild.nodeString == "SBAR" then

    	  root.each do |t|
    		  if !t.equals(root) then
    			  if t.isLeaf then
    				  leaf_counter += 1
    			  end

    			  if t.nodeString == "IN" && t.firstChild.nodeString != "if" then
    				  if !pp_list.isEmpty then
    					  y[:pp] << pp_list
    					  pp_list = arrayList.new
    				  end

    				  pp_list.addAll(t.getLeaves)

    				  prep_position = root.leftCharEdge(t)
    			  end

    			  if prep_position != nil && root.leftCharEdge(t) > prep_position && t.isLeaf then
    				  pp_list.add(t)
    			  end

    			  if leaf_counter == root.getLeaves.size && !y[:pp].include?(pp_list) && !pp_list.isEmpty then
    				  y[:pp] << pp_list
    			  end

    			  if t.nodeString == "SBAR" then
    				  y[:sub_clause] << t.getLeaves
    			  end
    		  end
    	  end
      end	  
	  end
	  
	  # Subtract repeated PP from Sub_clause
    y[:sub_clause].each do |currClause|
    	y[:pp].each do |currPP|
    		if currPP.containsAll(currClause) then
    			currPP.removeAll(currClause)
    		end

    		if currClause.containsAll(currPP) then
    			currClause.removeAll(currPP)
    		end
    	end
    end

    # Subtract repeated Sub_clause from PP
    y[:pp].each do |currPP|
    	y[:sub_clause].each do |currClause|
    		if currPP.containsAll(currClause) then
    			currPP.removeAll(currClause)
    		end
    	end
    end
    
    self.y_hyper0 = y[:hyper0]
    self.y_hyper1 = y[:hyper1]
    self.y_loc_hyper0 = y[:location].join(",")
    if !y[:pp].isEmpty? then
      for i in 0...y[:pp].size
        if i != y[:pp].size - 1 then
          self.y_pp += y[:pp][i].join(" ") + ", "
        else
          self.y_pp += y[:pp][i]
        end
      end
    end
    
    if !y[:sub_clause].isEmpty? then
      for i in 0...y[:sub_clause].size
        if i != y[:sub_clause].size - 1 then
          self.y_pp += y[:sub_clause][i].join(" ") + ", "
        else
          self.y_pp += y[:sub_clause][i]
        end
      end
    end
    #self.y_pp = y[:pp].join(",")
    #self.y_clause = y[:sub_clause].join(",")
  end
end
