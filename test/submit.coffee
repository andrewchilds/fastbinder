target = null

beforeEach ->
  target = null

describe 'Submit Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onSubmit').and.callFake ->
      target = @
      false

    fixture """
      <form id="parent" data-on-submit="MyLib.onSubmit">
        <input id="test" data-on-submit="MyLib.onSubmit" type="text" name="testName" value="testValue" />
        <input id="submit" type="submit" value="Submit" />
      </form>
      """

  it 'should handle submit events on the element', ->
    $('#test').focus()
    $('#test').trigger(jQuery.Event('keyup', { which: 13, keyCode: 13 }))
    $('#test').blur()
    expect(MyLib.onSubmit).toHaveBeenCalled()
    expect(target).toBe $('#test')[0]

  it 'should ignore keyup events on a non-input element', ->
    $('#parent').focus()
    $('#parent').trigger(jQuery.Event('keyup', { which: 13, keyCode: 13 }))
    $('#parent').blur()
    expect(MyLib.onSubmit).not.toHaveBeenCalled()

  it 'should handle proper form submit events on a form element', ->
    $('#submit').click()
    expect(MyLib.onSubmit).toHaveBeenCalled()
    expect(target).toBe $('#parent')[0]
