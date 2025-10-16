local WEBHOOK_URL = "https://discord.com/api/webhooks/1285595386529976364/pIk2UzKRgIOGg3jHql6HkxG7NEdJUN1YG2dk7W5xPCQqH3PWUHySxcnb2jv2XrlTD9my"
local MIN_GENERATION = 100

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local BrainrotData = {
    ["Noobini Pizzanini"] = {Generation = 1},
    ["Liril\195\172 Laril\195\160"] = {Generation = 3},
    ["Tim Cheese"] = {Generation = 5},
    ["Fluriflura"] = {Generation = 7},
    ["Svinina Bombardino"] = {Generation = 10},
    ["Talpa Di Fero"] = {Generation = 9},
    ["Pipi Kiwi"] = {Generation = 13},
    ["Pipi Corni"] = {Generation = 14},
    ["Raccooni Jandelini"] = {Generation = 12},
    ["Tartaragno"] = {Generation = 13},
    ["Trippi Troppi"] = {Generation = 15},
    ["Gangster Footera"] = {Generation = 30},
    ["Boneca Ambalabu"] = {Generation = 40},
    ["Ta Ta Ta Ta Sahur"] = {Generation = 55},
    ["Tric Trac Baraboom"] = {Generation = 65},
    ["Bandito Bobritto"] = {Generation = 35},
    ["Cacto Hipopotamo"] = {Generation = 50},
    ["Pipi Avocado"] = {Generation = 70},
    ["Pinealotto Fruttarino"] = {Generation = 75},
    ["Cappuccino Assassino"] = {Generation = 75},
    ["Brr Brr Patapim"] = {Generation = 100},
    ["Trulimero Trulicina"] = {Generation = 125},
    ["Bananita Dolphinita"] = {Generation = 150},
    ["Brri Brri Bicus Dicus Bombicus"] = {Generation = 175},
    ["Bambini Crostini"] = {Generation = 135},
    ["Perochello Lemonchello"] = {Generation = 160},
    ["Avocadini Guffo"] = {Generation = 225},
    ["Salamino Penguino"] = {Generation = 250},
    ["Ti Ti Ti Sahur"] = {Generation = 225},
    ["Penguino Cocosino"] = {Generation = 300},
    ["Avocadini Antilopini"] = {Generation = 115},
    ["Bandito Axolito"] = {Generation = 90},
    ["Malame Amarele"] = {Generation = 140},
    ["Mangolini Parrocini"] = {Generation = 235},
    ["Mummio Rappitto"] = {Generation = 325},
    ["Burbaloni Loliloli"] = {Generation = 200},
    ["Chimpanzini Bananini"] = {Generation = 300},
    ["Ballerina Cappuccina"] = {Generation = 500},
    ["Chef Crabracadabra"] = {Generation = 600},
    ["Glorbo Fruttodrillo"] = {Generation = 750},
    ["Blueberrinni Octopusini"] = {Generation = 1000},
    ["Lionel Cactuseli"] = {Generation = 650},
    ["Pandaccini Bananini"] = {Generation = 1250},
    ["Strawberrelli Flamingelli"] = {Generation = 1150},
    ["Cocosini Mama"] = {Generation = 1200},
    ["Pi Pi Watermelon"] = {Generation = 1300},
    ["Sigma Boy"] = {Generation = 1350},
    ["Pipi Potato"] = {Generation = 1100},
    ["Quivioli Ameleonni"] = {Generation = 900},
    ["Tirilikalika Tirilikalako"] = {Generation = 450},
    ["Caramello Filtrello"] = {Generation = 1050},
    ["Signore Carapace"] = {Generation = 1325},
    ["Sigma Girl"] = {Generation = 1800},
    ["Quackula"] = {Generation = 1275},
    ["Buho de Fuego"] = {Generation = 1850},
    ["Frigo Camelo"] = {Generation = 1900},
    ["Orangutini Ananassini"] = {Generation = 2000},
    ["Bombardiro Crocodilo"] = {Generation = 2500},
    ["Bombombini Gusini"] = {Generation = 5000},
    ["Rhino Toasterino"] = {Generation = 2150},
    ["Cavallo Virtuoso"] = {Generation = 7500},
    ["Spioniro Golubiro"] = {Generation = 3500},
    ["Zibra Zubra Zibralini"] = {Generation = 6000},
    ["Tigrilini Watermelini"] = {Generation = 6500},
    ["Gorillo Watermelondrillo"] = {Generation = 8000},
    ["Avocadorilla"] = {Generation = 7000},
    ["Ganganzelli Trulala"] = {Generation = 9000},
    ["Tob Tobi Tobi"] = {Generation = 8500},
    ["Te Te Te Sahur"] = {Generation = 9500},
    ["Tracoducotulu Delapeladustuz"] = {Generation = 12000},
    ["Lerulerulerule"] = {Generation = 8750},
    ["Carloo"] = {Generation = 13500},
    ["Carrotini Brainini"] = {Generation = 15000},
    ["Brutto Gialutto"] = {Generation = 3000},
    ["Gorillo Subwoofero"] = {Generation = 7750},
    ["Los Noobinis"] = {Generation = 12500},
    ["Rhino Helicopterino"] = {Generation = 11000},
    ["Elefanto Frigo"] = {Generation = 14000},
    ["Toiletto Focaccino"] = {Generation = 16000},
    ["Cachorrito Melonito"] = {Generation = 13000},
    ["Bananito Bandito"] = {Generation = 16500},
    ["Magi Ribbitini"] = {Generation = 11500},
    ["Jacko Spaventosa"] = {Generation = 16250},
    ["Chihuanini Taconini"] = {Generation = 45000},
    ["Cocofanto Elefanto"] = {Generation = 17500},
    ["Tralalero Tralala"] = {Generation = 50000},
    ["Odin Din Din Dun"] = {Generation = 75000},
    ["Girafa Celestre"] = {Generation = 20000},
    ["Trenostruzzo Turbo 3000"] = {Generation = 150000},
    ["Matteo"] = {Generation = 50000},
    ["Tigroligre Frutonni"] = {Generation = 60000},
    ["Orcalero Orcala"] = {Generation = 100000},
    ["Unclito Samito"] = {Generation = 75000},
    ["Gattatino Nyanino"] = {Generation = 35000},
    ["Espresso Signora"] = {Generation = 70000},
    ["Ballerino Lololo"] = {Generation = 200000},
    ["Piccione Macchina"] = {Generation = 225000},
    ["Los Crocodillitos"] = {Generation = 55000},
    ["Tukanno Bananno"] = {Generation = 100000},
    ["Trippi Troppi Troppa Trippa"] = {Generation = 175000},
    ["Los Tungtungtungcitos"] = {Generation = 210000},
    ["Agarrini la Palini"] = {Generation = 425000},
    ["Bulbito Bandito Traktorito"] = {Generation = 205000},
    ["Los Orcalitos"] = {Generation = 235000},
    ["Tipi Topi Taco"] = {Generation = 75000},
    ["Bombardini Tortinii"] = {Generation = 225000},
    ["Tralalita Tralala"] = {Generation = 100000},
    ["Urubini Flamenguini"] = {Generation = 150000},
    ["Alessio"] = {Generation = 85000},
    ["Pakrahmatmamat"] = {Generation = 215000},
    ["Los Bombinitos"] = {Generation = 220000},
    ["Brr es Teh Patipum"] = {Generation = 225000},
    ["Tartaruga Cisterna"] = {Generation = 250000},
    ["Cacasito Satalito"] = {Generation = 240000},
    ["Mastodontico Telepiedone"] = {Generation = 275000},
    ["Crabbo Limonetta"] = {Generation = 235000},
    ["Gattito Tacoto"] = {Generation = 165000},
    ["Los Tipi Tacos"] = {Generation = 260000},
    ["Antonio"] = {Generation = 18500},
    ["Las Capuchinas"] = {Generation = 185000},
    ["Orcalita Orcala"] = {Generation = 240000},
    ["Piccionetta Macchina"] = {Generation = 270000},
    ["Anpali Babel"] = {Generation = 280000},
    ["Extinct Ballerina"] = {Generation = 125000},
    ["Tractoro Dinosauro"] = {Generation = 230000},
    ["Belula Beluga"] = {Generation = 290000},
    ["Capi Taco"] = {Generation = 155000},
    ["Dug dug dug"] = {Generation = 255000},
    ["Corn Corn Corn Sahur"] = {Generation = 250000},
    ["Brasilini Berimbini"] = {Generation = 285000},
    ["Squalanana"] = {Generation = 250000},
    ["Pop Pop Sahur"] = {Generation = 295000},
    ["Vampira Cappucina"] = {Generation = 125000},
    ["Jacko Jack Jack"] = {Generation = 150000},
    ["Snailenzo"] = {Generation = 250000},
    ["Tentacolo Tecnico"] = {Generation = 292500},
    ["La Vacca Saturno Saturnita"] = {Generation = 300000},
    ["Los Tralaleritos"] = {Generation = 500000},
    ["Graipuss Medussi"] = {Generation = 1000000},
    ["La Grande Combinasion"] = {Generation = 10000000},
    ["Sammyni Spyderini"] = {Generation = 325000},
    ["Garama and Madundung"] = {Generation = 50000000},
    ["Torrtuginni Dragonfrutini"] = {Generation = 350000},
    ["Las Tralaleritas"] = {Generation = 650000},
    ["Pot Hotspot"] = {Generation = 2500000},
    ["Nuclearo Dinossauro"] = {Generation = 15000000},
    ["Las Vaquitas Saturnitas"] = {Generation = 750000},
    ["Chicleteira Bicicleteira"] = {Generation = 3500000},
    ["Los Combinasionas"] = {Generation = 15000000},
    ["Karkerkar Kurkur"] = {Generation = 300000},
    ["Dragon Cannelloni"] = {Generation = 200000000},
    ["Los Hotspotsitos"] = {Generation = 20000000},
    ["Esok Sekolah"] = {Generation = 30000000},
    ["Nooo My Hotspot"] = {Generation = 1500000},
    ["Los Matteos"] = {Generation = 300000},
    ["Job Job Job Sahur"] = {Generation = 700000},
    ["Dul Dul Dul"] = {Generation = 375000},
    ["Blackhole Goat"] = {Generation = 400000},
    ["Los Spyderinis"] = {Generation = 425000},
    ["Ketupat Kepat"] = {Generation = 35000000},
    ["La Supreme Combinasion"] = {Generation = 40000000},
    ["Bisonte Giuppitere"] = {Generation = 300000},
    ["Guerriro Digitale"] = {Generation = 550000},
    ["Ketchuru and Musturu"] = {Generation = 42500000},
    ["Spaghetti Tualetti"] = {Generation = 60000000},
    ["Los Nooo My Hotspotsitos"] = {Generation = 5500000},
    ["Trenostruzzo Turbo 4000"] = {Generation = 310000},
    ["Fragola La La La"] = {Generation = 450000},
    ["La Sahur Combinasion"] = {Generation = 2000000},
    ["La Karkerkar Combinasion"] = {Generation = 600000},
    ["Tralaledon"] = {Generation = 27500000},
    ["Los Bros"] = {Generation = 24000000},
    ["Los Chicleteiras"] = {Generation = 7000000},
    ["Chachechi"] = {Generation = 400000},
    ["Extinct Tralalero"] = {Generation = 450000},
    ["Extinct Matteo"] = {Generation = 625000},
    ["67"] = {Generation = 7500000},
    ["Las Sis"] = {Generation = 17500000},
    ["Celularcini Viciosini"] = {Generation = 22500000},
    ["La Extinct Grande"] = {Generation = 23500000},
    ["Quesadilla Crocodila"] = {Generation = 3000000},
    ["Tacorita Bicicleta"] = {Generation = 16500000},
    ["La Cucaracha"] = {Generation = 475000},
    ["To to to Sahur"] = {Generation = 2250000},
    ["Mariachi Corazoni"] = {Generation = 12500000},
    ["Los Tacoritas"] = {Generation = 32000000},
    ["Tictac Sahur"] = {Generation = 37500000},
    ["Yess my examine"] = {Generation = 575000},
    ["Karker Sahur"] = {Generation = 725000},
    ["Noo my examine"] = {Generation = 1750000},
    ["Money Money Puggy"] = {Generation = 21000000},
    ["Los Primos"] = {Generation = 31000000},
    ["Tang Tang Keletang"] = {Generation = 33500000},
    ["Perrito Burrito"] = {Generation = 1000000},
    ["Chillin Chili"] = {Generation = 25000000},
    ["Los Tortus"] = {Generation = 500000},
    ["Los Karkeritos"] = {Generation = 750000},
    ["Los Jobcitos"] = {Generation = 1500000},
    ["Los 67"] = {Generation = 22500000},
    ["La Secret Combinasion"] = {Generation = 125000000},
    ["Burguro And Fryuro"] = {Generation = 150000000},
    ["Zombie Tralala"] = {Generation = 500000},
    ["Vulturino Skeletono"] = {Generation = 500000},
    ["Frankentteo"] = {Generation = 700000},
    ["La Vacca Jacko Linterino"] = {Generation = 850000},
    ["Chicleteirina Bicicleteirina"] = {Generation = 4000000},
    ["Eviledon"] = {Generation = 31500000},
    ["La Spooky Grande"] = {Generation = 24500000},
    ["Los Mobilis"] = {Generation = 22000000},
    ["Spooky and Pumpky"] = {Generation = 80000000},
    ["Strawberry Elephant"] = {Generation = 350000000}
}

local notifiedPets = {}

local function sendWebhook(player, petName, generation)
    local playerCount = #Players:GetPlayers()
    local jobId = game.JobId

    local data = {
        ["embeds"] = {{
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "Player",
                    ["value"] = "`" .. player.Name .. "`",
                    ["inline"] = true
                },
                {
                    ["name"] = "Pet Name",
                    ["value"] = petName,
                    ["inline"] = true
                },
                {
                    ["name"] = "Generation",
                    ["value"] = tostring(generation),
                    ["inline"] = false
                },
                {
                    ["name"] = "Server Info",
                    ["value"] = string.format("`%d/8` players", playerCount),
                    ["inline"] = false
                },
                {
                    ["name"] = "Job ID",
                    ["value"] = "```" .. jobId .. "```"
                },
                {
                    ["name"] = "Join Script",
                    ["value"] = "```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(PLACE_ID, '" .. jobId .. "', game.Players.LocalPlayer)```"
                }
            },
            ["footer"] = {
                ["text"] = "Brainrot Scanner"
            }
        }}
    }

    pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data))
    end)
end

local function scanServer()
    local allChannels = Synchronizer:GetAllChannels()

    for _, channelData in pairs(allChannels) do
        if channelData.CacheTable and channelData.CacheTable.AnimalList and channelData.CacheTable.Owner then
            local owner = channelData.CacheTable.Owner
            local animalList = channelData.CacheTable.AnimalList

            for _, pet in ipairs(animalList) do
                if type(pet) == "table" and pet.Index then
                    local petInfo = BrainrotData[pet.Index]
                    
                    if petInfo and petInfo.Generation then
                        local generation = petInfo.Generation
                        local uniqueKey = owner.UserId .. "-" .. (pet.UUID or pet.Index)
                        
                        if generation >= MIN_GENERATION and not notifiedPets[uniqueKey] then
                            notifiedPets[uniqueKey] = true
                            sendWebhook(owner, pet.Index, generation)
                        end
                    end
                end
            end
        end
    end
end

while task.wait(15) do
    scanServer()
end
