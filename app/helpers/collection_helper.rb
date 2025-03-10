module CollectionHelper
  def id_index(id, ids)
    ids.index(id)
  end

  def next_id(id, ids)
    next_id = id_index(id, ids) + 1

    ids[next_id % ids.length]
  end

  def prev_id(id, ids)
    ids[id_index(id, ids) - 1]
  end
end
