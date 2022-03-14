class WorkOrderNumber

  def self.number_for_month
    WorkOrder.where(
      "created_at >= ? AND created_at <= ?",
      Time.current.beginning_of_month,
      Time.current.end_of_month
    )
    .count
    .next
  end

  def self.to_s
    Time.current.to_formatted_s(:work_order_number_prefix) +
    "-" +
    format('%04d', number_for_month)
  end

end
