json.extract! receipt, :id, :receipt_date, :for_month, :advance, :mess, :room_rent, :total, :payment_done, :student_id, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
