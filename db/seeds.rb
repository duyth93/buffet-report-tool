default_mazrica_template = '
◆ Today tasks
{{task-list}}
- #{{index}}: {{task}}
{{/task-list}}
◆ Actual
{{task-list}}
- #{{index}}: {{percent}}% ({{actual}})
{{/task-list}}
◆ Problems and Issues
{{problems}}
◆ Next day plan
{{next_day_plan}}
◆ Free Comment
{{free_comment}}
'

default_lawson_template = '
TO ALL >>>
[info][title] Daily report ({{today}})[/title]
■ Today schedule
{{task-list}}
- {{task}}
{{/task-list}}
■ Actual
{{task-list}}
- {{actual}}
{{/task-list}}
■ Reason cannot complete work
{{problems}}
■ Next day plan
{{next_day_plan}}
[/info]
'

Template.create content: default_mazrica_template, is_default: true, name: "Default Mazrica"
Template.create content: default_lawson_template, is_default: true, name: "Default Lawson"
