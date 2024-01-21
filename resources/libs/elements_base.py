from selenium.webdriver.common.by import By
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


@keyword('Clicar no primeiro elemento do site Amazon Brasil')
def click_first_element_amazon(LINK_AMAZON):
    selenium_lib = BuiltIn().get_library_instance('SeleniumLibrary')
    selenium_lib.wait_until_element_is_enabled(LINK_AMAZON)
    selenium_lib.click_element(LINK_AMAZON)


@keyword('Selecionar o item de maior para menor valor')
def click_first_element_high_price(SELECT_HIGH_PRICE):
    selenium_lib = BuiltIn().get_library_instance('SeleniumLibrary')
    selenium_lib.wait_until_element_is_visible(SELECT_HIGH_PRICE)
    selenium_lib.click_element(SELECT_HIGH_PRICE)