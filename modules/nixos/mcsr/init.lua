local waywall = require("waywall")
local helpers = require("waywall.helpers")

local Scene = require("waywork.scene")
local Modes = require("waywork.modes")
local Keys = require("waywork.keys")
local Processes = require("waywork.processes")

local scene = Scene.SceneManager.new(waywall)
local ModeManager = Modes.ModeManager.new(waywall)

local normal_sens = 7.09446097
local tall_sens = 0.47858809

local resolution = {
    default = {
        w = 1920,
        h = 1080,
    },
    thin = {
        w = 340,
        h = 1080,
    },
    wide = {
        w = 1920,
        h = 340,
    },
    tall = {
        w = 340,
        h = 16384,
    },
}

-- Processes.ensure_application is undocumented as far as i can see x_x, just taking from uku conf
local ensure_ninjabrain = Processes.ensure_application(waywall, programs.ninjabrain_bot)("ninjabrain.*\\.jar")
waywall.listen("load", ensure_ninjabrain)

scene:register("e_counter", {
    kind = "mirror",
    options = {
        src = { x = 1, y = 37, w = 49, h = 9 },
        dst = { x = 150, y = 495, w = 490, h = 90 }
    },
    groups = { "thin" },
})

scene:register("eye_measure", {
    kind = "mirror",
    options = {
        src = { x = 155, y = 7902, w = 30, h = 580 },
        dst = { x = 0, y = 370, w = 790, h = 340 },
    },
    groups = { "tall" },
})

scene:register("eye_overlay", {
    kind = "image",
    path = files.eye_overlay,
    options = {
        dst = { x = 0, y = 370, w = 790, h = 340 },
    },
    groups = { "tall" },
})

ModeManager:define("thin", {
    width = resolution.thin.w,
    height = resolution.thin.h,
    on_enter = function()
        scene:enable_group("thin", true)
    end,
    on_exit = function()
        scene:enable_group("thin", false)
    end,
})

ModeManager:define("tall", {
    width = resolution.tall.w,
    height = resolution.tall.h,
    on_enter = function()
        scene:enable_group("tall", true)
        waywall.set_sensitivity(tall_sens)
    end,
    on_exit = function()
        scene:enable_group("tall", false)
        waywall.set_sensitivity(0)
    end,
})

ModeManager:define("wide", {
    width = resolution.wide.w,
    height = resolution.wide.h,
    on_enter = function()
        scene:enable_group("wide", true)
    end,
    on_exit = function()
        scene:enable_group("wide", false)
    end,
})

local config = {
    input = {
        sensitivity = normal_sens,
    },
    theme = {
        background = "#00000000",
        ninb_anchor = "topright",
        ninb_opacity = 1,
    },
    actions = Keys.actions({
        ["*-EQUAL"] = function()
            return ModeManager:toggle("thin")
        end,
        ["*-GRAVE"] = function()
            return ModeManager:toggle("tall")
        end,
        ["*-SEMICOLON"] = function()
            return ModeManager:toggle("wide")
        end,
        ["Shift-N"] = function()
            ensure_ninjabrain()
            helpers.toggle_floating()
        end,
    })
}

return config
