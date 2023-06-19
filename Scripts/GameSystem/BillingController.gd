extends Control


var billing
var itemToken
func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"):
		billing = Engine.get_singleton("GodotGooglePlayBilling") # fired wehn you connect to the google api
		billing.connect("connected",self,"connected") # fired when you disconnect
		billing.connect("disconnected",self,"disconnected") # fired when you cant connect
		billing.connect("connect_error",self,"connect_error") # fired when you cant connect
		billing.connect("purchases_updated",self,"purchases_updated") # fired when you get your purchases
		billing.connect("purchase_error",self,"purchase_error") # fired when you cant get any purchases
		billing.connect("sku_details_query_completed",self,"sku_details_query_completed") # fired when you get youk sku details
		billing.connect("sku_details_query_error",self,"sku_details_query_error")# fired hwen you cant get you sku details
		billing.connect("purchase_acknowledged",self,"purchase_acknowledged") #fired when you purchases something
		billing.connect("purchase_acknowledgement_error",self,"purchase_acknowledgement_error")#fired when you cant purchase something
		billing.connect("purchase_consumed",self,"purchase_consumed")# fired when you use an item
		billing.connect("purchase_consumption_error",self,"purchase_consumption_error") # fired when you cant consume something
		billing.startConnection()


func purchase_error(error):
	print(error)

func connected():
	billing.querySkuDetails(["testsku"], "inapp")


func purchases_updated(items):
	for item in items:
		if !item.is_acknowledged:
			print("acknowledgePurchase: " + str(item.purchase_token))
			billing.acknowledgePurchase(item.purchase_token)
			$Label.text = "Galiba aldığımızı kullandık"
	if items.size() > 0:
		itemToken = items[items.size() - 1].purchase_token
		
		
func purchase_acknowledged(token):
	print("purchase was acknowledged! " + str(token))
	$Label.text = " Galiba satın aldık"
	
func purchase_consumed(token):
	print("item  was consumed " + token)
	

func _on_PuchaseItem_pressed():
	var response = billing.purchase("testsku")
	print("purchase has been attempted: result"  + str(response.status))
	if response.status != OK:
		print("error purchasing item")
	pass # Replace with function body.


func _on_UseItem_pressed():
	if itemToken == null:
		print("Error you need to buy this firs")
	else:
		print("consuming item")
		billing.consumePurchase(itemToken)
	pass # Replace with function body.
