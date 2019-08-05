ARIEMOTES = {}

ARIEMOTES[":ariannaawe"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaAwe:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannabless"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaBless:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannacry"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaCry:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannaderp"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaDerp:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannafail"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaFail:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannaheart"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaHeart:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannahey"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaHey:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannahug"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaHug:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannahype"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaHype:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannainnocent"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaInnocent:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannalove"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaLove:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannalul"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaLUL:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannamonkas"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaMonkaS:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannapog"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaPog:20:20:0:0:20:20:0:20:0:20\124t"
ARIEMOTES[":ariannarip"] = "\124TInterface/AddOns/AriannaChat/emotes/ariannaRip:20:20:0:0:20:20:0:20:0:20\124t"

function replaceAriannaEmotes(message, t, replaceStr, emote)
    local tp = t
    if emote then
        tp = string.sub(t, 1, 1).."%"..string.sub(t, 2, 2)
    end

    message = string.gsub(message, "^"..tp.."$", replaceStr) --solo emote
    message = string.gsub(message, "^"..tp.."(%s)", replaceStr.."%1") --emote at beginning with trailing space
    message = string.gsub(message, "(%s)"..tp.."(%s)", "%1"..replaceStr.."%2") --emote with leading and trailing space
    message = string.gsub(message, "(%s)"..tp.."$", "%1"..replaceStr) --emote at end with leading space

    return message
end

-- event function
function onChatMessage(self, event, message, ...)
    for t in string.gmatch(message, "%S+") do
        local lowerT = string.lower(t)
        if ARIEMOTES[lowerT] then
            local possibleEmote = string.sub(t, 2, 2) == ")" or string.sub(t, 2, 2) == "(" -- handle robot face emotes (this solution is borrowed from TwitchEmotes addon)
            message = replaceAriannaEmotes(message, t, ARIEMOTES[lowerT], possibleEmote)
        end
    end

    return false, message, ...
end

-- supported chat types which the code will apply to
local CHAT_TYPES = {
 "AFK",
 "BATTLEGROUND_LEADER",
 "BATTLEGROUND",
 "BN_WHISPER",
 "BN_WHISPER_INFORM",
 "CHANNEL",
 "DND",
 "EMOTE",
 "GUILD",
 "OFFICER",
 "PARTY_LEADER",
 "PARTY",
 "RAID_LEADER",
 "RAID_WARNING",
 "RAID",
 "SAY",
 "WHISPER",
 "WHISPER_INFORM",
 "YELL",
}

for _, type in pairs(CHAT_TYPES) do
    ChatFrame_AddMessageEventFilter("CHAT_MSG_" .. type, onChatMessage)
end
