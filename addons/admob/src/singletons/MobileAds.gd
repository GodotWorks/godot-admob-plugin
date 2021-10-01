extends Node 

var AdMobSettings = preload("res://addons/admob/src/utils/AdMobSettings.gd").new()
var plugin : Object

func _ready() -> void:	
	if AdMobSettings.config.general.is_enabled:
		if (Engine.has_singleton("AdMob")):
			plugin = Engine.get_singleton("AdMob")
			initialize()
			# warning-ignore:return_value_discarded
			get_tree().connect("screen_resized", self, "_on_get_tree_resized")

func get_is_initialized() -> bool:
	if plugin:
		return plugin.get_is_initialized()
	return false

func initialize() -> void:
	if plugin and not get_is_initialized():
		plugin.initialize(AdMobSettings.config.general.is_for_child_directed_treatment, AdMobSettings.config.general.max_ad_content_rating, OS.has_feature("release"), AdMobSettings.config.general.is_test_europe_user_consent)

func load_banner() -> void:
	if plugin:
		plugin.load_banner(AdMobSettings.config.banner.unit_ids[OS.get_name()][0], AdMobSettings.config.banner.position, AdMobSettings.config.banner.size, AdMobSettings.config.banner.show_instantly)

func load_interstitial() -> void:
	if plugin:
		plugin.load_interstitial(AdMobSettings.config.interstitial.unit_ids[OS.get_name()][0])

func load_rewarded() -> void:
	if plugin:
		plugin.load_rewarded(AdMobSettings.config.rewarded.unit_ids[OS.get_name()][0])

func load_rewarded_interstitial() -> void:
	if plugin:
		plugin.load_rewarded_interstitial(AdMobSettings.config.rewarded_interstitial.unit_ids[OS.get_name()][0])

func destroy_banner() -> void:
	if plugin:
		plugin.destroy_banner()

func show_banner() -> void:
	if plugin:
		plugin.show_banner()
		
func hide_banner() -> void:
	if plugin:
		plugin.hide_banner()

func show_interstitial() -> void:
	if plugin:
		plugin.show_interstitial()

func show_rewarded() -> void:
	if plugin:
		plugin.show_rewarded()

func show_rewarded_interstitial() -> void:
	if plugin:
		plugin.show_rewarded_interstitial()

func request_user_consent() -> void:
	if plugin:
		plugin.request_user_consent()

func reset_consent_state(will_request_user_consent := false) -> void:
	if plugin:
		plugin.reset_consent_state()

func get_banner_width() -> int:
	if plugin:
		return plugin.get_banner_width()
	return 0

func get_banner_width_in_pixels() -> int:
	if plugin:
		return plugin.get_banner_width_in_pixels()
	return 0
	
func get_banner_height() -> int:
	if plugin:
		return plugin.get_banner_height()
	return 0
	
func get_banner_height_in_pixels() -> int:
	if plugin:
		return plugin.get_banner_height_in_pixels()
	return 0
	
func get_is_banner_loaded() -> bool:
	if plugin:
		return plugin.get_is_banner_loaded()
	return false

func get_is_interstitial_loaded() -> bool:
	if plugin:
		return plugin.get_is_interstitial_loaded()
	return false

func get_is_rewarded_loaded() -> bool:
	if plugin:
		return plugin.get_is_rewarded_loaded()
	return false

func get_is_rewarded_interstitial_loaded() -> bool:
	if plugin:
		return plugin.get_is_rewarded_interstitial_loaded()
	return false
	
func _on_get_tree_resized() -> void:
	if plugin:
		if get_is_banner_loaded() and AdMobSettings.config.banner.size == "SMART_BANNER":
			load_banner()
		if get_is_interstitial_loaded(): #verify if interstitial and rewarded is loaded because the only reason to load again now is to resize
			load_interstitial()
		if get_is_rewarded_loaded():
			load_rewarded()
		if get_is_rewarded_interstitial_loaded():
			load_rewarded_interstitial()
