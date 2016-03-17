target = null

beforeEach ->
  target = null

describe 'Scroll Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onKeyup').and.callFake ->
      target = @
      false

    fixture """
      <div id="parent">
        <input id="test" data-on-keyup="MyLib.onKeyup" type="text" name="testName" value="testValue" />
      </div>
      """

  describe 'with a keyup delay of 10ms', ->
    beforeEach (done) ->
      $.fastbinder.setOptions({ keyupDelay: 10 })
      $('#test').focus()
      $('#test').keyup()
      $('#test').blur()
      setTimeout done, 20

    it 'should handle keyup events on the element with a delay', ->
      expect(MyLib.onKeyup).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

  describe 'without a keyup delay', ->
    beforeEach ->
      $.fastbinder.setOptions({ keyupDelay: 0 })

    it 'should handle keyup events on the element', ->
      $('#test').focus()
      $('#test').keyup()
      $('#test').blur()
      expect(MyLib.onKeyup).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should ignore keyup events on a parent element', ->
      $('#parent').focus()
      $('#parent').keyup()
      $('#parent').blur()
      expect(MyLib.onKeyup).not.toHaveBeenCalled()
