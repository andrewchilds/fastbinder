target = null

beforeEach ->
  target = null

describe 'Scroll Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onKeyup').andCallFake -> target = @
    fixture """
      <div id="parent">
        <input id="test" data-on-keyup="MyLib.onKeyup" type="text" name="testName" value="testValue" />
      </div>
      """

  describe 'with a keyup delay of 10ms', ->
    beforeEach ->
      $.fastbinder.setOptions({ keyupDelay: 10 })

    it 'should handle keyup events on the element with a delay', ->
      expect(MyLib.onKeyup).not.toHaveBeenCalled()
      $('#test').focus()
      $('#test').keyup()
      $('#test').blur()
      # $('#test').trigger(jQuery.Event('keyup', { which: 13, keyCode: 13 }))
      expect(MyLib.onKeyup).not.toHaveBeenCalled()
      waits(20)
      runs ->
        expect(MyLib.onKeyup).toHaveBeenCalled()
        expect(target).toBe $('#test')[0]

  describe 'without a keyup delay', ->
    beforeEach ->
      $.fastbinder.setOptions({ keyupDelay: 0 })

    it 'should handle keyup events on the element', ->
      expect(MyLib.onKeyup).not.toHaveBeenCalled()
      $('#test').focus()
      $('#test').keyup()
      $('#test').blur()
      # $('#test').trigger(jQuery.Event('keyup', { which: 13, keyCode: 13 }))
      expect(MyLib.onKeyup).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should ignore keyup events on a parent element', ->
      expect(MyLib.onKeyup).not.toHaveBeenCalled()
      $('#parent').focus()
      $('#parent').keyup()
      $('#parent').blur()
      # $('#parent').trigger(jQuery.Event('keyup', { which: 13, keyCode: 13 }))
      expect(MyLib.onKeyup).not.toHaveBeenCalled()
