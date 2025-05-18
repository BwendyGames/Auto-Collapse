@tool
extends EditorPlugin

var script_editor: Control

func _enter_tree():
    script_editor = get_editor_interface().get_script_editor()
    if script_editor:
        script_editor.visibility_changed.connect(_on_script_editor_visibility_changed)

func _exit_tree():
    if script_editor and script_editor.visibility_changed.is_connected(_on_script_editor_visibility_changed):
        script_editor.visibility_changed.disconnect(_on_script_editor_visibility_changed)

func _on_script_editor_visibility_changed():
    if script_editor.visible:
        hide_bottom_panel()
    else:
        # There's no direct "show bottom panel" function, but if a plugin or tab was last selected,
        # this will bring it back:
        get_editor_interface().get_editor_main_screen().call_deferred("update")  # Slight UI refresh
