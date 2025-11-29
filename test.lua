-- This function calculates the sum of two numbers
function calculateSum(a, b)
	-- A comment that could be refactored or formatted
	local result = a + b
	return result
end

-- Call the function
local num1 = 10
local num2 = 5
local sum = calculateSum(num1, num2)
print("The sum is: " .. sum)

-- An undefined variable, which an LSP might flag as an error or provide a quick fix
local undefinedVariable = nonExistentVariable
