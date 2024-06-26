When(/^que eu tenho um JSON válido$/) do
  @valid_json = File.read(Rails.root.join('spec/support/classes.json'))
end

When(/^que eu tenho json invalido$/) do
  @invalid_json = { code: "MAT101", name: "Mathematics 1" }.to_json
end

When(/^fazer uma requisição Post em "\/import_materia_and_turma"$/) do |arg|
  post path, params: { data: @valid_json }, as: :json
end

When(/^devo ver "([^"]*)"$/) do |arg|
  expect(response.parsed_body["message"]).to eq(message)
end

When(/^Materia deve ser criado$/) do
  expect(Materia.count).to eq(3)
end

When(/^Turma deve ser criado$/) do
  expect(Materia.first.turmas.first.codigo).to eq("TA")
end
