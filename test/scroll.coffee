target = null

beforeEach ->
  target = null

describe 'Scroll Event Handling', ->

  beforeEach ->
    spyOn(MyLib, 'onScroll').and.callFake ->
      target = @
      false

    fixture """
      <div id="parent">
        <div id="test" data-on-scroll="MyLib.onScroll" style="width: 500px; height: 10000px;">
          <div id="child">Test</div>
        </div>
      </div>
      """

  describe 'with a scroll delay of 10ms', ->
    beforeEach (done) ->
      $.fastbinder.setOptions({ scrollDelay: 10 })
      $('#test').scroll()
      setTimeout done, 20

    it 'should handle scrolls on the element with a delay', ->
      expect(MyLib.onScroll).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

  describe 'without a scroll delay', ->
    beforeEach ->
      $.fastbinder.setOptions({ scrollDelay: 0 })

    it 'should handle scrolls on the element', ->
      $('#test').scroll()
      expect(MyLib.onScroll).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should handle scrolls on a child element', ->
      $('#child').scroll()
      expect(MyLib.onScroll).toHaveBeenCalled()
      expect(target).toBe $('#test')[0]

    it 'should ignore scrolls on a parent element', ->
      $('#parent').scroll()
      expect(MyLib.onScroll).not.toHaveBeenCalled()
