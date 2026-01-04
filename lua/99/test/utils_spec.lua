-- luacheck: globals describe it assert
local eq = assert.are.same
local Utils = require("99.utils")

describe("wrap_output", function()
    it("should be single line", function()
        local raw_output =
            "I just wanted to say that I really, I really tried to type a real good string"

        local expected_output = {
            "I just wanted to say that I really, I really tried to type a real good string",
        }
        eq(expected_output, Utils.wrap_output(raw_output))
    end)

    it("should be 2 lines", function()
        local raw_output =
            "I just want to type a big string, but I don't have the creativity yet to make it good, so I'm sorry ☹️"

        local expected_output = {
            "I just want to type a big string, but I don't have the creativity yet to make it",
            "good, so I'm sorry ☹️",
        }
        eq(expected_output, Utils.wrap_output(raw_output))
        eq(80, string.len(expected_output[1]))
    end)

    it("should break big words", function()
        local raw_output =
            "Okay, so I'll try to write this bigwordthatimthinkingabouttotypebutimnotsureifitwouldbebigenough"

        local expected_output = {
            "Okay, so I'll try to write this bigwordthatimthinkingabouttotypebutimnotsureifi-",
            "twouldbebigenough",
        }
        eq(expected_output, Utils.wrap_output(raw_output))
        eq(80, string.len(expected_output[1]))
    end)
end)
