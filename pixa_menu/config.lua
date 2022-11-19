Config = {}







Config.Menus = {

    ['default_f1'] = {

            {

                event = "pixa_menu:OpenInventory",

                icon = "fas fa-briefcase",

                label = "Ekwipunek",

            },

            {

                event = "pixa_menu:OpenPhone",

                icon = "fas fa-mobile-alt",

                label = "Telefon",

            },

            {

                event = "pixa_menu:OpenAnimationsMenu",

                icon = "fas fa-walking",

                label = "Animacje",

            },

            {

                event = "pixa_menu:OpenPostac",

                icon = "fas fa-user",

                label = "Postać",

            },

            {

                event = "pixa_menu:OpenGarage",

                icon = "fas fa-car",

                label = "Pojazdy",

            },

            {

                event = "pixa_menu:currentVehicle",

                icon = "fas fa-car-side",

                label = "Aktualny pojazd",

                shouldDraw = 'IsPedInAnyVehicle(PlayerPedId())',

                drawing = false

            },

            {

                event = "pixa_misc:OutFromTrunk",

                icon = "fas fa-car-side",

                label = "Wyjdź z bagażnika",

                shouldDraw = 'print("Tu powinien byc jakis super swiaty kurwa trigger albo export albo natywka")',

                drawing = false

            },



            {

                event = "disc_drugruns:endRun",

                icon = "fas fa-pills",

                label = "Zakończ misję z Oxy",

                shouldDraw = 'print("Tu powinien byc jakis super swiaty kurwa trigger albo export albo natywka")',

                drawing = false

            },



            {

                event = "taxi_npc:cancelTaxi",

                icon = "fas fa-taxi",

                label = "Anuluj taksówkę",

                shouldDraw = 'print("Tu powinien byc jakis super swiaty kurwa trigger albo export albo natywka")',

                drawing = false

            },



            {

                event = "mrp_cows:AmbulanceOptions",

                icon = "fas fa-ambulance",

                label = "Usługi szpitalne",

                shouldDraw = 'print("Tu powinien byc jakis super swiaty kurwa trigger albo export albo natywka")',

                drawing = false

            },



           --[[ {

                event = "pixa_menu:pickupSnowball",

                icon = "fas fa-snowflake",

                label = "Podnieś śniezkę",

                shouldDraw = 'not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0)',

                drawing = false

            },]]

                

    },

    ['postac_f1'] = {

        {

            event = "pixa_menu:OpenStats",

            icon = "fas fa-medal",

            label = "Umiejętności",

        },

        {

            event = "pixa_menu:OpenKluczeMenu",

            icon = "fas fa-key",

            label = "Klucze",

        },

        {

            event = "pixa_menu:OpenGarage2",

            icon = "fas fa-car",

            label = "Pojazdy organizacji",

        }, 

        {

            event = "pixa_menu:showIDYourself",

            icon = "far fa-id-card",

            label = "Dowód",

        },    

        

        {

            event = "pixa_weapons:getComponents",

            icon = "fas fa-skull",

            label = "Dodatki do broni",

            shouldDraw = 'GetSelectedPedWeapon(PlayerPedId()) ~= -1569615261',

            drawing = false

        },

    },



   

    ['menu_DMV'] = {

        {

            event = "pixa_menu:DMV_A",

            icon = "fas fa-scroll",

            label = "Prawo jazdy Kat. A",

        },

        {

            event = "pixa_menu:DMV_B",

            icon = "fas fa-scroll",

            label = "Prawo jazdy Kat. B",

        },

        {

            event = "pixa_menu:DMV_C",

            icon = "fas fa-scroll",

            label = "Prawo jazdy Kat. C",

        },

        {

            event = "pixa_menu:DMV_TEORETYCZNY",

            icon = "fas fa-scroll",

            label = "Teoretyczny ROA",

        },

          

    },





    ['menu_aktualnypojazd'] = {

        {

            event = "pixa_menu:OpenDoorsMenu",

            icon = "fas fa-car",

            label = "Drzwi",

        },

        {

            event = "pixa_menu:CarRadio",

            icon = "fas fa-volume-up",

            label = "Radio",

        },



        {

            event = "przebieg:getcar",

            icon = "fas fa-car",

            label = "Stan pojazdu",

        },

 

    },

    ['menu_drzwi'] = {

        {

            event = "pixa_menu:PrzednieLewe",

            icon = "fas fa-car",

            label = "Przednie Lewe",

        },

        {

            event = "pixa_menu:PrzedniePrawe",

            icon = "fas fa-car",

            label = "Przednie Prawe",

        },

        {

            event = "pixa_menu:TylnieLewe",

            icon = "fas fa-car",

            label = "Tylnie Lewe",

        },

        {

            event = "pixa_menu:TylniePrawe",

            icon = "fas fa-car",

            label = "Tylnie Prawe",

        },

        {

            event = "pixa_menu:Bagaznik",

            icon = "fas fa-car",

            label = "Bagażnik",

        },

        {

            event = "pixa_menu:Maska",

            icon = "fas fa-car",

            label = "Maska",

        },     

}

}