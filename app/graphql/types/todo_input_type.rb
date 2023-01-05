class Types::TodoInputType < Types::BaseInputObject
  argument :name, String, required: true
  argument :status, String, required: true
end