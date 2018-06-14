# frozen_string_literal: true

require 'sinatra'

set :bind, '0.0.0.0'

post '/api/v1/response' do
  request.body.rewind  
  raw_data = request.body.read
  data = JSON.parse raw_data
  halt 400, 'uuid required' unless data.has_key? 'uuid'
  halt 400, 'content required' unless data.has_key? 'content'
  halt 400, 'content has to be a hash' unless data['content'].is_a? Hash
  halt 400, 'Response not found' unless data['uuid'] == '5b48bb2c-6003-4d11-9bbb-8a33fa8a6e51' || data['uuid'] == '3dd5e6e4-89e6-4f30-a271-dfe5ebb06980'
  raw_data
end

# nodoc
get '/api/v1/response' do
  id = params[:external_identifier]
  halt 404, 'external_identifier required' unless id
  halt 401, 'External id not allowed (the only valid one is 1234)' unless id == '1234'
  content_type :json
  [
    {
      'uuid' => '5b48bb2c-6003-4d11-9bbb-8a33fa8a6e51',
      'questionnaire' => {
        'key' => 'student_diary',
        'title' => 'dagboek studenten',
        'name' => 'DONT USE THIS ONE, USE title'
      }
    },
    {
      'uuid' => '3dd5e6e4-89e6-4f30-a271-dfe5ebb06980',
      'questionnaire' => {
        'key' => 'mentor_diary',
        'title' => 'dagboek mentoren',
        'name' => 'DONT USE THIS NAME, USE title'
      }
    }
  ].to_json
end

get '/api/v1/response/:uuid' do
  uuid = params[:uuid]
  content_type :json
  if uuid == '5b48bb2c-6003-4d11-9bbb-8a33fa8a6e51'
    {
      'uuid' => '5b48bb2c-6003-4d11-9bbb-8a33fa8a6e51',
      'questionnaire_title' => 'dagboek studenten',
      'questionnaire_content' => [
        {
          'type' => 'unsubscribe',
          'title' => 'Klaar met dit schooljaar?',
          'content' => "Ben je klaar met dit schooljaar? Klik dan op de knop 'Onderzoek afronden' om het onderzoek te voltooien. Zo nee, vul dan gewoon de onderstaande vragenlijst in.",
          'button_text' => 'Onderzoek afronden',
          'show_after' => '2018-06-06T11:56:22.043+02:00'
        },
        {
          'section_start' => 'School en Stage',
          'type' => 'raw',
          'content' => '<p class="flow-text section-explanation">De volgende vragen gaan over school en stage. Je antwoorden zijn helemaal anoniem.</p>'
        },
        {
          'id' => 'v1',
          'type' => 'radio',
          'title' => 'Ben je de afgelopen week naar school en/of stage geweest?',
          'options' => [
            {
              'title' => 'Ja',
              'shows_questions' => %w[
                v2
                v3
                v4
                v5
                v6
              ]
            },
            'Nee'
          ],
          'show_otherwise' => false
        },
        {
          'id' => 'v2',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Wat heb je de afgelopen week <strong>meegemaakt op school en/of stage</strong>?',
          'tooltip' => 'Neem hierbij een paar ervaringen in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'vooral nare dingen',
            'vooral leuke dingen'
          ]
        },
        {
          'id' => 'v3',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Heb je afgelopen week meestal <strong>dingen op school en/of stage gedaan omdat</strong> je het moest of omdat je het zelf wilde?',
          'tooltip' => 'Neem hierbij een paar ervaringen in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'omdat ik moest',
            'omdat ik het zelf wilde'
          ]
        },
        {
          'id' => 'v4',
          'hidden' => true,
          'type' => 'range',
          'title' => '<strong>Hoe goed heb je dingen gedaan op school en/of stage</strong> afgelopen week?',
          'tooltip' => 'Neem hierbij een paar ervaringen in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'heel slecht',
            'heel goed'
          ]
        },
        {
          'id' => 'v5',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Kon je afgelopen week goed <strong>opschieten met vrienden op school en/of stage</strong>?',
          'tooltip' => 'Neem hierbij een paar ervaringen met vrienden in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'heel slecht',
            'heel goed'
          ]
        },
        {
          'id' => 'v6',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Kon je afgelopen week goed <strong>opschieten met leraren op school en/of begeleiders op stage</strong>?',
          'tooltip' => 'Neem hierbij een paar ervaringen met leraren (of leidinggevenden op stage) in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'heel slecht',
            'heel goed'
          ]
        },
        {
          'id' => 'v7',
          'type' => 'range',
          'title' => '<strong>Hoeveel tijd</strong> heb je afgelopen week besteed aan school, stage en huiswerk bij elkaar?',
          'tooltip' => 'Een grove gok is prima, het is niet erg als je er een paar uur naast zit.',
          'labels' => [
            '0 uur',
            '40 uur of meer'
          ],
          'max' => 40
        },
        {
          'id' => 'v8',
          'type' => 'range',
          'title' => 'Was dit <strong>genoeg tijd</strong> om goed te presteren op school?',
          'labels' => [
            'niet genoeg tijd',
            'te veel tijd'
          ]
        },
        {
          'id' => 'v9',
          'type' => 'range',
          'title' => 'Ben je op dit moment blij met je <strong>keuze voor deze opleiding</strong>?',
          'labels' => [
            'niet blij met keuze',
            'heel blij met keuze'
          ]
        },
        {
          'id' => 'v10',
          'type' => 'range',
          'title' => 'Vind je op dit moment dat je <strong>opleiding</strong> bij je past?',
          'labels' => [
            'past niet goed',
            'past heel goed'
          ]
        },
        {
          'id' => 'v11',
          'type' => 'range',
          'title' => 'Heb je er op dit moment vertrouwen in dat je dit <strong>schooljaar gaat halen</strong>?',
          'labels' => [
            'geen vertrouwen',
            'veel vertrouwen'
          ],
          'section_end' => true
        },
        {
          'section_start' => 'Buiten School',
          'type' => 'raw',
          'content' => '<p class="flow-text section-explanation">De volgende vragen gaan over de tijd die je besteedt buiten school. Je antwoorden zijn helemaal anoniem.</p>'
        },
        {
          'id' => 'v12',
          'type' => 'range',
          'title' => 'Wat heb je de afgelopen week <strong>meegemaakt buiten school</strong>?',
          'tooltip' => 'Neem hierbij een paar ervaringen in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'vooral nare dingen',
            'vooral leuke dingen'
          ]
        },
        {
          'id' => 'v13',
          'type' => 'checkbox',
          'title' => 'Waar hadden de belangrijkste gebeurtenissen mee te maken? Je mag meerdere antwoorden geven.',
          'options' => [
            'hobby/sport',
            'werk',
            'vriendschap',
            'romantische relatie',
            'thuis'
          ]
        },
        {
          'id' => 'v14',
          'type' => 'range',
          'title' => 'Heb je afgelopen week de meeste <strong>dingen buiten school gedaan omdat</strong> je het moest of omdat je het zelf wilde?',
          'tooltip' => 'Neem hierbij een paar ervaringen in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'omdat ik moest',
            'omdat ik wilde'
          ]
        },
        {
          'id' => 'v15',
          'type' => 'range',
          'title' => '<strong>Hoe goed heb je dingen gedaan buiten school</strong> afgelopen week?',
          'tooltip' => 'Neem hierbij een paar ervaringen in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'heel slecht',
            'heel goed'
          ]
        },
        {
          'id' => 'v16',
          'type' => 'range',
          'title' => 'Kon je afgelopen week meestal goed <strong>opschieten met vrienden buiten school</strong>?',
          'tooltip' => 'Neem hierbij een paar ervaringen met vrienden in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'heel slecht',
            'heel goed'
          ]
        },
        {
          'id' => 'v17',
          'type' => 'range',
          'title' => 'Kon je afgelopen week meeestal goed <strong>opschieten met ouders/familie buiten school</strong>?',
          'tooltip' => 'Neem hierbij een paar ervaringen met ouders of familie in gedachten die voor jou belangrijk waren.',
          'labels' => [
            'heel slecht',
            'heel goed'
          ],
          'section_end' => true
        },
        {
          'section_start' => 'Begeleiding',
          'type' => 'raw',
          'content' => '<p class="flow-text section-explanation">De volgende vragen gaan over de persoonlijke begeleiding die je krijgt van Default organization. Je antwoorden zijn helemaal anoniem.</p>'
        },
        {
          'id' => 'v18',
          'type' => 'radio',
          'title' => 'Heb je de afgelopen week Anna gesproken?',
          'options' => [
            {
              'title' => 'Ja',
              'shows_questions' => %w[
                v19
                v20
                v21
                v22
                v23
                v24
              ]
            },
            'Nee'
          ]
        },
        {
          'id' => 'v19',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Kon je afgelopen week goed <strong>opschieten met Anna</strong>?',
          'labels' => [
            'heel slecht',
            'heel goed'
          ]
        },
        {
          'id' => 'v20',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Hoe <strong>open</strong> was je <strong>in wat je vertelde</strong> aan Anna afgelopen week?',
          'labels' => %w[
            gesloten
            open
          ]
        },
        {
          'id' => 'v21',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Heeft Anna je goed geholpen afgelopen week?',
          'labels' => [
            'niet goed geholpen',
            'heel goed geholpen'
          ]
        },
        {
          'id' => 'v22',
          'hidden' => true,
          'type' => 'range',
          'title' => 'In hoeverre voelde jij je afgelopen week gesteund door Anna in het maken van je eigen beslissingen?',
          'labels' => [
            'niet',
            'heel sterk'
          ]
        },
        {
          'id' => 'v23',
          'hidden' => true,
          'type' => 'range',
          'title' => 'In hoeverre had jij het gevoel dat Anna er voor je was deze week?',
          'labels' => [
            'niet',
            'heel sterk'
          ]
        },
        {
          'id' => 'v24',
          'hidden' => true,
          'type' => 'range',
          'title' => 'In hoeverre gaf Anna je afgelopen week het gevoel dat je dingen goed kan?',
          'labels' => [
            'niet',
            'heel sterk'
          ],
          'section_end' => true
        },
        {
          'section_start' => 'Algemeen',
          'type' => 'raw',
          'content' => '<p class="flow-text section-explanation">De volgende vraag gaat over jou in het algemeen. Het gaat dit keer dus niet over een specifieke omgeving, zoals eerder in deze vragenlijst. Je antwoord is helemaal anoniem.</p>'
        },
        {
          'id' => 'v25',
          'type' => 'range',
          'title' => 'Hoe voelde jij je deze week?',
          'labels' => [
            'Heel slecht',
            'Heel goed'
          ],
          'section_end' => true
        }
      ]
    }.to_json
  elsif uuid == '3dd5e6e4-89e6-4f30-a271-dfe5ebb06980'
    {
      'uuid' => '3dd5e6e4-89e6-4f30-a271-dfe5ebb06980',
      'questionnaire_title' => '',
      'questionnaire_content' => [
        {
          'id' => 'v1',
          'type' => 'radio',
          'show_otherwise' => false,
          'title' => 'Heb je deze week acties ondernomen in de begeleiding van Erika?',
          'options' => [
            {
              'title' => 'Ja',
              'shows_questions' => %w[
                v3
                v4
                v5
                v6
                v7
                v8
                v9
              ]
            },
            {
              'title' => 'Nee',
              'shows_questions' => [
                'v2'
              ]
            }
          ]
        },
        {
          'id' => 'v2',
          'hidden' => true,
          'type' => 'radio',
          'title' => 'Waarom heb je deze week geen acties ondernomen in de begeleiding van Erika?',
          'options' => [
            'Ik heb deze week geen contact gehad met Erika.',
            {
              'title' => 'Ik ben gestopt met de begeleiding van Erika.',
              'shows_questions' => %w[
                v14
                v15
              ],
              'stop_subscription' => true,
              'tooltip' => 'Let op => als je deze optie selecteert word je hierna niet meer gevraagd om vragenlijsten in te vullen over Erika.'
            },
            {
              'title' => 'Erika is gestopt met de opleiding.',
              'shows_questions' => %w[
                v16
                v17
                v18
              ]
            },
            {
              'title' => 'Ik heb de begeleiding van Erika overgedragen aan iemand anders.',
              'shows_questions' => %w[
                v10
                v11
                v12
                v13
              ]
            }
          ]
        },
        {
          'id' => 'v3',
          'hidden' => true,
          'title' => '',
          'add_button_label' => 'Nog een actie(reeks) toevoegen',
          'remove_button_label' => 'Verwijder actie(reeks)',
          'type' => 'expandable',
          'default_expansions' => 1,
          'max_expansions' => 10,
          'content' => [
            {
              'section_start' => 'Actie(reeks)',
              'id' => 'v3_1',
              'type' => 'textarea',
              'required' => true,
              'title' => "Welke belangrijke actie, of reeks aan acties die volgens jou bij\n      elkaar horen (bijv. omdat ze hetzelfde doel dienen of kort achter elkaar zijn\n      uitgevoerd), heb jij uitgevoerd in de begeleiding van Erika?",
              'tooltip' => 'Acties zijn bijvoorbeeld gesprekken, whatsappjes, oefeningen en huisbezoeken. Je mag jouw actie(s) kort beschrijven in steekwoorden of in verhaalvorm.'
            },
            {
              'id' => 'v3_2',
              'type' => 'checkbox',
              'required' => true,
              'title' => 'In welke categorie(ën) past de zojuist beschreven actie(reeks) volgens jou het beste?',
              'options' => [
                {
                  'title' => 'Laagdrempelig contact leggen',
                  'tooltip' => 'bijv. whatsappen of samen tafeltennissen, wandelen of roken.'
                },
                {
                  'title' => 'Visuele oefeningen uitvoeren',
                  'tooltip' => 'bijv. een netwerkschema op papier uittekenen of in Powerpoint gedragsschema’s met Erika uitwerken.'
                },
                {
                  'title' => 'Verbale oefeningen uitvoeren',
                  'tooltip' => 'bijv. een rollenspel spelen of Erika laten presenteren.'
                },
                {
                  'title' => 'Motiveren',
                  'tooltip' => 'bijv. vertrouwen naar Erika uitspreken dat zij haar tentamen kan halen, Erika aansporen tot het maken van een presentatie of Erika aanmoedigen tijdens een sportevent.'
                },
                {
                  'title' => 'Confronteren',
                  'tooltip' => 'bijv. Erika een spreekwoordelijke spiegel voorhouden, aanspreken op onhandig gedrag of provocatief coachen.'
                },
                {
                  'title' => 'Uitleg geven',
                  'tooltip' => 'bijv. Erika informeren over middelengebruik of over de kenmerken van ADHD.'
                },
                {
                  'title' => 'Ondersteunen van schoolwerk',
                  'tooltip' => 'bijv. Erika helpen met plannen of samen met Erika haar leerstof doornemen.'
                },
                {
                  'title' => 'Emotionele steun bieden',
                  'tooltip' => 'bijv. empathisch reageren op een nare ervaring van Erika, of Erika een luisterend oor bieden.'
                },
                {
                  'title' => 'De omgeving van Erika betrekken bij de begeleiding',
                  'tooltip' => 'bijv. ouders, vrienden, leraren of hulpverleners uitleg geven over Erika haar gedrag of vragen om mee te helpen in de begeleiding van Erika.'
                },
                {
                  'title' => 'Hulp vragen aan/overleggen met collega’s of andere professionals',
                  'tooltip' => 'bijv. hulp vragen aan een psycholoog of maatschappelijk werker om mee te helpen/denken in de begeleiding van Erika.'
                },
                {
                  'title' => 'Observaties doen',
                  'tooltip' => 'bijv. een voetbalwedstrijd bekijken of Erika observeren tijdens pauzes of lessen.'
                }
              ],
              'otherwise_tooltip' => 'kies dit cluster alleen wanneer de door jouw gekozen actie niet bij andere clusters past.'
            },
            {
              'id' => 'v3_3',
              'type' => 'checkbox',
              'required' => true,
              'title' => 'Aan welke doelen heb jij gewerkt door deze actie(s) uit te voeren?',
              'options' => [
                {
                  'title' => 'De relatie met Erika verbeteren en/of onderhouden',
                  'tooltip' => 'bijv. de band met Erika proberen te verbeteren of laten weten dat je er voor Erika bent.'
                },
                {
                  'title' => 'Emotioneel welzijn van Erika ontwikkelen',
                  'tooltip' => 'bijv. Erika leren om haar emoties beter onder controle te krijgen of om haar emotie(s) beter aan te laten sluiten op situatie(s).'
                },
                {
                  'title' => 'Vaardigheden van Erika ontwikkelen',
                  'tooltip' => 'bijv. sociale of schoolse vaardigheden trainen, zoals plannen. Of Erika trainen hoe zij beter met probleemsituaties om kan gaan.'
                },
                {
                  'title' => 'Erika zelfinzicht geven',
                  'tooltip' => 'bijv. Erika inzicht geven in haar eigen gedrag, emoties, gedachten of relaties met anderen.'
                },
                {
                  'title' => 'Inzicht krijgen in de belevingswereld van Erika',
                  'tooltip' => 'bijv. proberen te achterhalen hoe Erika denkt, of hoe zij zich voelt en waarom zij zo denkt of voelt.'
                },
                {
                  'title' => 'Inzicht krijgen in de omgeving van Erika',
                  'tooltip' => "bijv. verdiepen in wat zij zoal meemaakt op school of tijdens haar hobby('s), verdiepen in Erika haar familiedynamiek of achterhalen met wie zij zoal omgaat."
                },
                {
                  'title' => 'De omgeving van Erika veranderen',
                  'tooltip' => 'bijv. kennis vergroten bij ouders, vrienden en leraren van Erika, of hen overtuigen om Erika hulp te bieden.'
                }
              ],
              'otherwise_tooltip' => 'kies dit cluster alleen wanneer het door jouw gekozen doel niet bij andere clusters past.'
            },
            {
              'id' => 'v3_4',
              'type' => 'range',
              'title' => 'Hoe belangrijk denk jij dat deze actie(reeks) was voor de voortgang van Erika in haar begeleidingstraject?',
              'labels' => [
                'niet belangrijk',
                'heel belangrijk'
              ]
            },
            {
              'id' => 'v3_51',
              'type' => 'checkbox',
              'show_otherwise' => false,
              'title' => 'Hoe tevreden ben je met de interactie tussen jou en Erika?',
              'options' => [
                {
                  'title' => 'Niet van toepassing',
                  'hides_questions' => [
                    'v3_5'
                  ]
                }
              ]
            },
            {
              'id' => 'v3_5',
              'hidden' => false,
              'type' => 'range',
              'title' => '',
              'labels' => [
                'ontevreden',
                'heel tevreden'
              ],
              'section_end' => true
            }
          ]
        },
        {
          'id' => 'v4',
          'hidden' => true,
          'type' => 'time',
          'hours_from' => 0,
          'hours_to' => 11,
          'hours_step' => 1,
          'title' => 'Hoeveel tijd heb je deze week besteed aan de begeleiding van Erika?',
          'section_start' => 'Overige vragen'
        },
        {
          'id' => 'v5',
          'hidden' => true,
          'type' => 'range',
          'title' => 'Waren jouw acties in de begeleiding van Erika deze week vooral gepland of vooral intuïtief?',
          'labels' => [
            'helemaal intuïtief ',
            'helemaal gepland'
          ]
        },
        {
          'id' => 'v6',
          'hidden' => true,
          'type' => 'range',
          'title' => 'In hoeverre heb jij deze week geprobeerd Erika te ondersteunen in het maken van haar eigen beslissingen?',
          'labels' => [
            'niet',
            'heel sterk'
          ]
        },
        {
          'id' => 'v7',
          'hidden' => true,
          'type' => 'range',
          'title' => 'In hoeverre heb jij deze week geprobeerd Erika het gevoel te geven dat zij dingen goed kan?',
          'labels' => [
            'niet',
            'heel sterk'
          ]
        },
        {
          'id' => 'v8',
          'hidden' => true,
          'type' => 'range',
          'title' => 'In hoeverre heb jij deze week geprobeerd Erika het gevoel te geven dat je er voor haar bent?',
          'labels' => [
            'niet',
            'heel sterk'
          ],
          'section_end' => true
        },
        {
          'id' => 'v9',
          'hidden' => true,
          'type' => 'radio',
          'show_otherwise' => false,
          'title' => 'Heb je de begeleiding van Erika deze week grotendeels overgedragen aan een andere persoon?',
          'tooltip' => 'Met grotendeels bedoelen wij voor meer dan de helft',
          'options' => [
            {
              'title' => 'Ja',
              'shows_questions' => %w[
                v10
                v11
                v12
              ]
            },
            {
              'title' => 'Nee'
            }
          ]
        },
        {
          'id' => 'v10',
          'hidden' => true,
          'type' => 'textarea',
          'title' => 'Waarom heb jij de begeleiding (grotendeels) overgedragen?'
        },
        {
          'id' => 'v11',
          'hidden' => true,
          'type' => 'textarea',
          'title' => 'Aan wie heb jij de begeleiding (grotendeels) overgedragen?'
        },
        {
          'id' => 'v12',
          'hidden' => true,
          'type' => 'textarea',
          'title' => 'Wat denk jij dat diegene deze week heeft gedaan in de begeleiding van Erika?'
        },
        {
          'id' => 'v13',
          'hidden' => true,
          'type' => 'raw',
          'content' => '<p class="flow-text section-explanation">Is de overdracht van begeleiding van permanente aard? Mail dan de telefoonnummers van jou, Erika en de nieuwe begeleider naar <a href="mailto:n.r.snell@rug.nl">n.r.snell@rug.nl</a>.</p>'
        },
        {
          'id' => 'v14',
          'hidden' => true,
          'type' => 'textarea',
          'title' => 'Waarom ben je gestopt met de begeleiding van Erika?'
        },
        {
          'id' => 'v15',
          'hidden' => true,
          'type' => 'radio',
          'title' => 'Denk jij dat Erika nog steeds risico loopt om voortijdig te stoppen met haar opleiding?',
          'options' => %w[
            Ja
            Nee
          ]
        },
        {
          'id' => 'v16',
          'hidden' => true,
          'type' => 'textarea',
          'title' => 'Waarom is Erika gestopt met haar opleiding?'
        },
        {
          'id' => 'v17',
          'hidden' => true,
          'type' => 'radio',
          'title' => 'Wat gaat Erika doen nu zij gestopt is met haar opleiding?',
          'options' => [
            'Werken',
            'Een andere opleiding volgen',
            'Weet ik niet'
          ]
        },
        {
          'id' => 'v18',
          'hidden' => true,
          'type' => 'radio',
          'title' => 'Stopt jouw begeleiding van Erika nu zij met de opleiding is gestopt?',
          'options' => [
            {
              'title' => 'Ja',
              'stop_subscription' => true,
              'tooltip' => 'Let op => als je deze optie selecteert word je hierna niet meer gevraagd om vragenlijsten in te vullen over Erika.'
            },
            'Nee'
          ]
        }
      ]
    }.to_json
  else
    halt 404, 'Response not found'
  end
end
