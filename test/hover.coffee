target = null

beforeEach ->
  target = null

describe 'Hover Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onHover').and.callFake ->
      target = @
      false

    fixture """
      <div id="parent">
        <div id="test" data-on-hover="MyLib.onHover">
          <div id="child">Test</div>
        </div>
      </div>
      """

  describe 'with a hover delay of 10ms', ->
    beforeEach (done) ->
      $.fastbinder.setOptions({ hoverDelay: 10 })
      $('#test').mousemove()
      setTimeout done, 20

    it 'should handle hovers on the element with a delay', ->
      expect(MyLib.onHover).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

  describe 'without a hover delay', ->
    beforeEach ->
      $.fastbinder.setOptions({ hoverDelay: 0 })

    it 'should handle hovers on the element', ->
      $('#test').mousemove()
      expect(MyLib.onHover).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should handle hovers on a child element', ->
      $('#child').mousemove()
      expect(MyLib.onHover).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should ignore hovers on a parent element', ->
      $('#parent').mousemove()
      expect(MyLib.onHover).not.toHaveBeenCalled()
